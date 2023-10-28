# A Time-Based (Tracking) Log

## 1. Background

We, human beings, tend to lost clue on things as time passing, and prefer starting things without ending them. We need help.

## 2. Philosophy

- **Simplicity**

    Nothing compares to simplicity coz human brain is precious and pretending to stuck on complex things, and favoring forgetting things.

- **Goal-aimed**

    Tasks without goals wouldn't make that much senses, aligning tasks with a goal would make a difference.

- **Time-based**

    Human crawling on time line forward, no way back, at least, true for now.

- **Context-saving**

    Context helps a lot when tracking back things. **Incremental modification** is preferred over **overwritten modification** for saving context as much as possible.

- **Text-based**

    Text is prefered due to simplicity and zero-effort on transporting, and text is naturally tool-independent.

## 3. Data Structure

A tog consists of several date-stampped blocks with each block consisting of a date-stamp and a list of tasks with each task consisting of a task status, a task id and a task content.

A simple tog content would be like:

```
23-02-24
// ...

23-02-25
.= 230225081528 write a doc for tog
.: 230225125800 @230225081528 writing doc @output:./tog.md @finishedAt:230225150000
=  230225160000 go out and have some fun
:  230225161200 @230225160000 yeah
```

## 4. Conceptions

### 4.1 Date-Stampped Block
Date-Stamp Block is essential parts of tog content, a block contains a Date-Stamp and a list of tasks.

### 4.2 Date-Stamp
Date-Stamp represents the date of the Date-Stamp Block and always be put head of the block. For simplicity, Date-Stamp can be formed as `"%Y-%m-%d"`, eg: `23-02-25`.

### 4.3 Task

A Task mainly consists of three parts: task status, task id, and task content.

#### 4.3.1 Task Status

Task status comes very ahead of the task line, for easier human eyes tracking and easier program parsing.

There are two types of status:

1. Non-terminal status

- `=` - TODO
- `:` - DOING, meaning focusing current task now

2. Terminal status

- `.` - DONE
- `x` - DEPRECATED

**When a task with terminal status occurs and it has preceding tasks, the terminal status should be synced to all preceding tasks by putting (instead of overwriting) the terminal status AT VERY HEAD of all status of all preceding tasks for reserving status changing records**.

Example:

```
.= ID1 some task content
.: ID2 @ID1 task content with progress
.: ID3 @ID1 more progress on the initial task
. ID4 @ID1 end

x= ID5 some task content
x: ID6 @ID5 task content with progress
x: ID7 @ID5 more progress on the initial task
x ID8 @ID5 end
```

#### 4.3.2 Task ID

Task ID should be unique and meaningful, so timestamp (`"%Y%m%d%H%M%S"`) is a perfect candidate. With timestamp as task id, no extra time record is needed to present task's create time.

- `ID` - ID of task.

Task ID can be refered.

- `@ID` - A task reference referring to the task whose id is `ID`. If a task is referred by one or multiple tasks, it becomes a **goal task**, and the tasks referring to it become a **follow-up tasks** link with each task sorted by task's timestamp in asc order.

So, logically, there are three types of tasks:

- Normal task - A task is naturally a normal task.
- Goal task - A task who has been referred by one or multiple tasks.
- Follow-up task - A task whose content contains one or multiple task references.

For Example for following tasks,

```
.= ID1 some task content
.: ID2 @ID1 task content with progress
.: ID3 @ID1 more progress on the initial task
. ID4 @ID1 temp end
```

The changing log can be visually represented as (on time-axis):

```
=ID1
=ID1 --> :ID2                        # ID1 becomes a goal task
=ID1 --> :ID2 --> :ID3
.=ID1 --> .:ID2 --> .:ID3 --> .ID4   # sync terminal status, after status synced,
                                     # all status of all preceding tasks in follow-up
                                     # link become terminal.

Past --------------------------------------------------------------------> Future
```

And for following tasks,

```
.= ID1 some task content
.: ID2 @ID1 step 1 to process
.: ID3 @ID1 step 2 to process
. ID4 @ID2 temp end
.: ID5 @ID3 working on
. ID6 @ID3 after some work, done here
. ID7 @ID1 explictly end initial task
```

The changing log can be visually represented as (on time-axis):

```
=ID1

=ID1 --> :ID2                         # ID1 becomes a goal task

=ID1 --> :ID2 --> :ID3

=ID1 --> .:ID2 --> :ID3
           \
            ------------> .ID4        # ID2 becomes a goal task.
                                      # After terminal status synced,
                                      # all status of all preceding task in
                                      # follow-up link become terminal, that
                                      # is ID2 becomes terminal too, but
                                      # status of ID1 stays coz it's not ID1
                                      # but ID2 the goal task of the link.

=ID1 --> .:ID2 --> :ID3
           \         \
            ----------\-> .ID4
                       \
                        -------> :ID5 # ID3 becomes a goal task

=ID1 --> .:ID2 --> .:ID3
           \         \
            ----------\-> .ID4
                       \
                        -------> .:ID5 ------> .ID6        # sync terminal status

.ID1 --> .:ID2 --> .:ID3 ---------------------------> .ID7 # sync terminal status
            \         \
             ----------\-> .ID4
                        \
                         -------> .:ID5 ------> .ID6

Past --------------------------------------------------------------------> Future
```

#### 4.3.3 Task Content

Task content is an arbitrary string representing the content, and inline attributes can be used to make content more meaningful and more structive.

- `@ATTRIBUTE_KEY:ATTRIBUTE_VALUE` - `"@"` as attribute marker and with `ATTRIBUTE_KEY` and `ATTRIBUTE_VALUE` seperated by `":"`. `ATTRIBUTE_VALUE` need to be quoted when contains white space.

Example:

```
{STATUS} {ID} write my work week-report @output:"~/work logs/week-report-09.md"
{STATUS} {ID} sign contract @priority:high @finishedAt:2302251124800
{STATUS} {ID} research power tool @url:https://duckduckgo.com/?q=power+tool
{STATUS} {ID} plan to play football @mention:"John Eric" @mention:football-team
```

### 4.5 Tag
Tag is powerful tool to classify things. Tag can be applied to Date-Stamp and tasks.

- `#TAG` - Starts with `"#"` and followed by arbitrary string.

### 4.6 Comment

- `// COMMENT` - Starts with `"//"` and followed by arbitrary string.

## 5. Applications

Can be used for managing/tracking tasks and things changing via time.

## 6. Conclusion

## 7. References
- [markdown - https://daringfireball.net/projects/markdown/](https://daringfireball.net/projects/markdown/)
- [markdown guide - https://www.markdownguide.org](https://www.markdownguide.org/)
- [org-mode - https://orgmode.org](https://orgmode.org)

## 8. Copyright

Refer to [LICENSE](./LICENSE) for license.


