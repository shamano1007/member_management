class @BulkOperationTable
  constructor: (targetTable = 'table')->
    @targetTable = $(targetTable)

  addBtn: ->
    alert('追加')

  deleteBtn: ->
    alert('削除')
