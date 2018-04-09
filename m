From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 9 Apr 2018 17:17:38 +0200
Subject: [LTP] Ticket tracking system for LTP
Message-ID: <20180409151738.GA2522@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Recently, as there has been more people working on LTP in SUSE than
myself, we started to accumulate LTP TODO items in our internal tool.
These include general ideas about LTP improvements, missing coverage,
broken tests, etc.

Keeping this backlog behind closed door is unhealty for upstream project
so I'm looking into some kind of system to track these where everyone
can create new tickets/bugs/issues whatever it is called and act on
them.

The main problem here is to choose right tool for the job, which is the
main reason for this email. I would like to avoid clumsy solutions such
as wiki table or a spreadsheet (I've been there and it was painful even
for a team of two people).

Here are some requirements I came up for it:

* Supports creating/commenting/closing issues/tickets/bugs or
  whatever is single smallest entity is called as by anybody (possibly
  after a simple registration)

* Should be reasonably simple and be able to handle >100 of open
  issues, which I suppose rules out things that are tailored to be
  used to support agile workflow such as trello that would end up
  visually incomprehensible

* Should have basic text search capabilities

* Ideally we will not maintain the instance ourselves
  - that rules out things like redmine unless there is
    an instance we can easily tap into

* Data export is a plus
  - I want to avoid situation where we loose our data
    after a database corruption

* Should be reasonably estabilished
  - I want to avoid a situation where we start to use some tool only to
    find it has been discontinued half a year later

* Ideally it should be opensource
  - however beggars can't be choosers we use GitHub quite extensively
    after all

There is a list of poissibilities I have so far:

* GitHub issues
  - probably the easiest solution
  - we can create a specific labels to sort these out
  - needs GitHub account which everybody has already
  - some operations could be done only by LTP project members
    I'm not sure if random users can add labels for example

* Some instance of Bugzilla
  (maybe bugzilla.kernel.org if we happen to get LTP category there)
   - while this would be OK for missing coverage and broken test
     I find bugzilla clumsy general ideas tracking

* I've been told that JIRA is free for opensource projects but I have no
  idea how the tool works or if it's at least reasonable fit. I looks to
  me like it has far to many features we do not need at all.

* ??? (anything else any of you can think of?)


Rant: Actually I'm a bit disappointed that there is no command line tool
      similar to taskwarrior.org maybe with a git backend for this kind
      of backlog/team management...

-- 
Cyril Hrubis
chrubis@suse.cz
