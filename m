From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 2 Mar 2017 13:41:59 +0100
Subject: [LTP] [PATCH] Remove unneeded time() declaration.
In-Reply-To: <1488389181.2866.256.camel@caviumnetworks.com>
References: <1488317719-29809-1-git-send-email-sellcey@caviumnetworks.com>
 <20170301124620.GA32207@rei.lan>
 <1488389181.2866.256.camel@caviumnetworks.com>
Message-ID: <20170302123608.GA30493@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I updated the comments and resent the patch using format-patch and
> send-email. ??I am not sure if that is the right way to do it but I
> don't see any way to use format-patch/send-email to resend the patch as
> a response to your email so I sent it as a new email/thread. ??The
> inability (as far as I know) to update the patch and send it as a
> response to an existing email thread is one of the reasons I am not a
> huge fan of those tools but if that is how you want it done, I will do
> it that way.

The usuall way is to send new version of a patchset as new thread,
ideally adding vN to the subject where N is number that increases with
each iteration.

And yes, the git-send-email is tailored to specific workflow so as far
as the workflow works for particular project, everything works great.

But the same goes for GitHub, I do not like the workflow their tools are
tailored for, but I still use them when needed. And quite possibly I do
not like it since I'm still much more used to sending patches by
email...

Anyway all that matters in the end is that patches gets applied :-).

-- 
Cyril Hrubis
chrubis@suse.cz
