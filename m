From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 10 May 2021 11:11:29 +0200
Subject: [LTP] LTP Release
In-Reply-To: <YJVPP64LuDK7O564@pevik>
References: <YJOYgZNL7/qp5YCN@yuki> <YJPo4L0QnXHU7xks@pevik>
 <YJVPP64LuDK7O564@pevik>
Message-ID: <YJj4wftakLE7PECd@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > also solving Shell API timeout sleep orphan processes would be good [1]
> > There is already C patch [2] + Li suggested to fix the shell implementation
> > using trap in subshell [3].
> OK there is shell implementation to fix orphan processes [4] from Joerg, which
> would be worth do fix it, Li already did a review, I'll look into it today.

I would like to get to a git freeze soon. I will have a look as well but
if it's not ready in the first half of this week I would just postpone
it rather than rush it.

> I'd like to rebase and send to ML IMA dm-crypt test for testing. If Mimi, Tushar
> or Lakshmi find time to test it, I'd like to have it in the release.

Here as well, if things are tested and ready soon enough then go ahead
and apply it.

I would like to freeze the git and start pre release testing, if
possible, in the second half of this week. If there is anything else
that should be fixed please speak up now.

-- 
Cyril Hrubis
chrubis@suse.cz
