module Nike

  def just_do_it interactive, pipeline, options = {}
    working_dir = case options[:in_dir]
      when :local_path then self.local_path
      when :parent_dir then self.parent_dir
      else Dir.pwd
    end
    Dir.chdir(working_dir) do
      if Git::Meta.interactive?
        puts "%s (%s)" % [
          self.name.invert,
          self.fractional_index
        ]
        interactive.call(self)
      else
        pipeline.call(self)
      end
    end
  end

end
