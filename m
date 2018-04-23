From: Dan Rue <dan.rue@linaro.org>
Date: Mon, 23 Apr 2018 08:38:40 -0500
Subject: [LTP] Ticket tracking system for LTP
In-Reply-To: <20180409151738.GA2522@rei>
References: <20180409151738.GA2522@rei>
Message-ID: <20180423133840.cj5vah2xlm3urly6@xps>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Apr 09, 2018 at 05:17:38PM +0200, Cyril Hrubis wrote:
> Hi!
> Recently, as there has been more people working on LTP in SUSE than
> myself, we started to accumulate LTP TODO items in our internal tool.
> These include general ideas about LTP improvements, missing coverage,
> broken tests, etc.
> 
> Keeping this backlog behind closed door is unhealty for upstream project
> so I'm looking into some kind of system to track these where everyone
> can create new tickets/bugs/issues whatever it is called and act on
> them.
> 
> The main problem here is to choose right tool for the job, which is the
> main reason for this email. I would like to avoid clumsy solutions such
> as wiki table or a spreadsheet (I've been there and it was painful even
> for a team of two people).
> 
> Here are some requirements I came up for it:
> 
> * Supports creating/commenting/closing issues/tickets/bugs or
>   whatever is single smallest entity is called as by anybody (possibly
>   after a simple registration)
> 
> * Should be reasonably simple and be able to handle >100 of open
>   issues, which I suppose rules out things that are tailored to be
>   used to support agile workflow such as trello that would end up
>   visually incomprehensible
> 
> * Should have basic text search capabilities
> 
> * Ideally we will not maintain the instance ourselves
>   - that rules out things like redmine unless there is
>     an instance we can easily tap into
> 
> * Data export is a plus
>   - I want to avoid situation where we loose our data
>     after a database corruption
> 
> * Should be reasonably estabilished
>   - I want to avoid a situation where we start to use some tool only to
>     find it has been discontinued half a year later
> 
> * Ideally it should be opensource
>   - however beggars can't be choosers we use GitHub quite extensively
>     after all
> 
> There is a list of poissibilities I have so far:
> 
> * GitHub issues
>   - probably the easiest solution
>   - we can create a specific labels to sort these out
>   - needs GitHub account which everybody has already
>   - some operations could be done only by LTP project members
>     I'm not sure if random users can add labels for example

+1. It meets the requirements (except open source), and is already
established. To be successful, LTP's github probably needs more
curation. I see a lot of pull requests and issues opened for a long time
without any action. This is true of any solution, of course.

Also, importantly, github is where the developers are (like it or not).

> * Some instance of Bugzilla
>   (maybe bugzilla.kernel.org if we happen to get LTP category there)
>    - while this would be OK for missing coverage and broken test
>      I find bugzilla clumsy general ideas tracking

-1.. The world of open source bug tracking is a bit sad. We're looking
at moving LKFT's bugzilla to phabricator
(https://github.com/phacility/phabricator). Still, moving from perl to
php feels like an improvement but not a solution (or maybe my biases are
showing).

> * I've been told that JIRA is free for opensource projects but I have no
>   idea how the tool works or if it's at least reasonable fit. I looks to
>   me like it has far to many features we do not need at all.

-10. Just, don't use jira.

> * ??? (anything else any of you can think of?)

I think github is a great solution for this project.

Dan

> 
> 
> Rant: Actually I'm a bit disappointed that there is no command line tool
>       similar to taskwarrior.org maybe with a git backend for this kind
>       of backlog/team management...
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp
