From: Li Wang <liwang@redhat.com>
Date: Fri, 27 Apr 2018 15:41:23 +0800
Subject: [LTP] [PATCH] commands: Remove all test cases
In-Reply-To: <1448033218.16051780.1524813651315.JavaMail.zimbra@redhat.com>
References: <20180426132418.19495-1-schlad@suse.de>
 <20180426132418.19495-2-schlad@suse.de>
 <b72b277b-e8e0-d69c-b918-bd48341c2a1d@oracle.com>
 <20180426164928.6c86604e@linux-p5n0>
 <1448033218.16051780.1524813651315.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2fZWvksKegZffNvq4Cv7FLm0v2q66VE52p1OvLmwnHHZQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Fri, Apr 27, 2018 at 3:20 PM, Jan Stancek <jstancek@redhat.com> wrote:

>
> ----- Original Message -----
> >
> > Honestly I just wanted to pick your brain and ask community what's the
> > best approach for commands testing.
> >
> > One might also say - better leave them there and do not run them if you
> > are not happy with it. Sure.
> >
> > So really over to community and maintainers to advise what would be the
> > best approach here.
>
> I'd go one by one. For those that are broken, propose them to be removed
> and CC people who touched it in last ~2-3 years.
>
> @Li: Does ltp/general run all commands? Are there failures?
>
>
​Yes, ltp/general test include that.​

​The LTP commands test always works fine for RHEL,​ I just find only 1
failure on upstream kernel-v4.17-rc2 yesterday, but I have not get a chance
to look into it.

Kernel Version: 4.17.0-rc2
Machine Architecture: ppc64le

<<<test_start>>>
tag=lsmod01 stime=1524645511
cmdline="lsmod01.sh"
contacts=""
analysis=exit
<<<test_output>>>
lsmod01 1 TFAIL: lsmod output different from /proc/modules.
15c15
< loop 31719 2
---
> loop 31719 1

Summary:
passed   0
failed   1
skipped  0
warnings 0




-- 
Li Wang
liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180427/d291e4da/attachment.html>
