

global  with sharing class Stack {
    private List<Object> items {get; set;}

    public Stack() {
        this.items = new List<Object>();
    }

    public Integer size() {
        return this.items.size();
    }

    public Boolean isEmpty() {
        return size() == 0;
    }

    public void push(Object itemToPush) {
        this.items.add(itemToPush);
    }

    // the exact same thing that push, only here because the method name
    // is more familiar for apex developer when they push something to a list or Array.
    public void add(Object itemToPush) {
        this.items.add(itemToPush);
    }

    public Object pop() {
        if (isEmpty()) {
            throw new NullPointerException();
        }

        return this.items.remove(size() - 1);
    }

    public Object peek() {
        if (isEmpty()) {
            throw new NullPointerException();
        }

        return this.items.get(size() - 1);
    }
}
