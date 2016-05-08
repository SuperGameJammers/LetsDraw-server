defmodule Habanero.CallPython do
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
end