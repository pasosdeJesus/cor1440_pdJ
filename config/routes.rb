Rails.application.routes.draw do

  scope '/cor1440pdJ' do
    devise_scope :usuario do
      get 'sign_out' => 'devise/sessions#destroy'

      # El siguiente para superar mala generación del action en el formulario
      # cuando se monta en sitio diferente a / y se autentica mal (genera 
      # /puntomontaje/puntomontaje/usuarios/sign_in )
      if (Rails.configuration.relative_url_root != '/') 
        ruta = File.join(Rails.configuration.relative_url_root, 
                         'usuarios/sign_in')
        post ruta, to: 'devise/sessions#create'
        get  ruta, to: 'devise/sessions#new'
      end
    end

    devise_for :usuarios, :skip => [:registrations], module: :devise
    as :usuario do
      get 'usuarios/edit' => 'devise/registrations#edit', 
        :as => 'editar_registro_usuario'    
      put 'usuarios/:id' => 'devise/registrations#update', 
        :as => 'registro_usuario'            
    end
    resources :usuarios, path_names: { new: 'nuevo', edit: 'edita' } 

    get '/proyectofinanciero/copia/:proyectofinanciero_id' =>
    'cor1440_gen/proyectosfinancieros#copia',
      as: :copia_proyectofinanciero

    root 'sip/hogar#index'
  end
  mount Sip::Engine, at: '/cor1440pdJ', as: 'sip'
  mount Heb412Gen::Engine, at: "/cor1440pdJ", as: "heb412_gen"
  mount Mr519Gen::Engine, at: "/cor1440pdJ", as: "mr519_gen"
  mount Cor1440Gen::Engine, at: "/cor1440pdJ", as: 'cor1440_gen'
end
