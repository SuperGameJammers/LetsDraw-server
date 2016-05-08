defmodule Habanero do
  use Application
  require IEx

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # Start the endpoint when the application starts
      supervisor(Habanero.Endpoint, []),
      # Start the Ecto repository
      supervisor(Habanero.Repo, []),
      # Here you could define other workers and supervisors as children
      # worker(Habanero.Worker, [arg1, arg2, arg3]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Habanero.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Habanero.Endpoint.config_change(changed, removed)
    :ok
  end

  def smart_script(link1, link2)  do
    {:ok, pid} = :python.start([{:python_path, to_char_list(Path.expand("lib/machine_learning_py"))},{:python, 'python'}])
    :python.call(pid, :smart_script, :compareImages, [link1, link2])
  end
  def predict(filePath)  do
    {:ok, pid} = :python.start([{:python_path, to_char_list(Path.expand("lib/machine_learning_py"))},{:python, 'python'}])
    :python.call(pid, :mashainLearnz, :learn, [filePath])
  end

  def train(filePath)  do
    {:ok, pid} = :python.start([{:python_path, to_char_list(Path.expand("lib/machine_learning_py"))},{:python, 'python'}])
    :python.call(pid, :mashainLearnz, :train, [filePath])
  end

  def test_python do
<<<<<<< HEAD
    {:ok, pid} = :python.start([{:python_path, to_char_list(Path.expand("lib/machine_learning_py"))},{:python, 'python'}])
    :python.call(pid, :test, :version, [])
=======
        {:ok, pid} = :python.start([{:python_path, to_char_list(Path.expand("lib/machine_learning_py"))},{:python, 'python'}])
        :python.call(pid, :test, :version, [filePath])
>>>>>>> 0bb876dcaa2534df387e96db0c1b7b1532e7e057
  end
end
