From: Li Wang <liwang@redhat.com>
Date: Wed, 27 Jan 2021 21:05:52 +0800
Subject: [LTP] [PATCH] Fix tst_pollute_memory() safety margin for huge
 systems
In-Reply-To: <YBFcc/lc+KkC49Gq@yuki.lan>
References: <20210127115606.28985-1-mdoucha@suse.cz>
 <YBFWrJoS1tVmWGFx@yuki.lan>
 <2021012720143348660139@chinatelecom.cn> <YBFcc/lc+KkC49Gq@yuki.lan>
Message-ID: <CAEemH2fe3qA230XhkU3Jwt52gcX0mRXj8XULjwjYzeq4v1rRog@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Jan 27, 2021 at 8:27 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > According my test,malloc amount greater than available memory,then
> invoke the oom-killer.
>
> However that does not mean that allocating MemAvailable or slightly less
> than MemAvailable is safe. In fact it's not, at least that I've been
> told be kernel developers. I will try to figure out something safe
> enough with their help.
>

If we only hope to avoid trigger OOM during allocating until the
MAP_FAILED, I think the knob 'proc/sys/vm/overcommit_memory'
maybe helpful.

e.g.

  set overcommit_memory = 2, overcommit_ratio = 85 or 90;
  ... memory allocating as much as you can ...
  restore the value of overcommit_*

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210127/dbf6179c/attachment-0001.htm>
