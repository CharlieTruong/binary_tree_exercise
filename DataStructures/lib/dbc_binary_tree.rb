class DBCBinaryTree
  
  def initialize(root = nil)
    @root = root
  end

  def to_s
    @root.nil? ? '[]' : @root.to_s
  end

  def empty?
    @root.nil? ? true : false
  end

  def size
    @root.nil? ? 0 : @root.size
  end

  def depth
    @root.nil? ? 0 : @root.depth
  end

  def insert(val)
    new_node = BinaryNode.new(val)

    if @root.nil?
      @root = new_node
    else
      @root.add_child(new_node)
    end
  end

  def find(val)
    @root.find(val)
  end

  def preorder(node = @root, &block)
    block.call(node.val)
    preorder(node.left, &block) if !node.left.nil?
    preorder(node.right, &block) if !node.right.nil?
  end

  def inorder(node = @root, &block)
    if node.left.nil?
      block.call(node.val)
    else
      inorder(node.left, &block) 
      block.call(node.val)
      inorder(node.right, &block)
    end  
  end

  def postorder(node = @root, &block)
    if node.left.nil?
      block.call(node.val)
    else
      postorder(node.left, &block)
      postorder(node.right, &block) 
      block.call(node.val)
    end  
  end

  def map(&block)
    new_tree = self.class.new
    preorder {|i| new_tree.insert(block.call(i))}
    new_tree
  end

end

class BinaryNode

  attr_reader :left, :right, :val

  def initialize(val)
    @val = val
    @left = nil
    @right = nil
  end

  def find(val)
    if val == @val
      true
    elsif val > @val && !@right.nil?
      @right.find(val)
    elsif val < @val && !@left.nil?
      @left.find(val)
    else
      false
    end
  end

  def depth
    left_depth = @left.nil? ? 0 : @left.depth
    right_depth = @right.nil? ? 0 : @right.depth
    1 + [left_depth, right_depth].max
  end

  def add_child(node)
    if @right.nil? && node.val > @val
      @right = node
    elsif @left.nil? && node.val < @val
      @left = node
    elsif node.val > @val
      @right.add_child(node)
    else
      @left.add_child(node)
    end
  end

  def to_s
    left = @left.nil? ? '-' : @left.to_s
    right = @right.nil? ? '-' : @right.to_s
    '[' + left + ' ' + @val.to_s + ' ' + right + ']'
  end

  def size
    left_size = @left.nil? ? 0 : @left.size
    right_size = @right.nil? ? 0 : @right.size
    1 + left_size + right_size
  end
end