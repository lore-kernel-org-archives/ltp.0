From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 4 Jun 2021 19:12:09 +0200
Subject: [LTP] [RFC] Remove disktest from LTP
In-Reply-To: <YLh9jvI/p/VxsSmx@pevik>
References: <YLh9jvI/p/VxsSmx@pevik>
Message-ID: <CAASaF6yHHty1m+1U-buHUt4P80fnoTqXTaSO7G-YBm=REWZyWw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Jun 3, 2021 at 8:58 AM Petr Vorel <pvorel@suse.cz> wrote:

> Hi,
>
> does anybody use testcases/kernel/io/disktest ?
>
> It supports various OS, but not sure if it's relevant now in SSD era.
> Last update was in 2008 (version 1.4.2).
>

I don't think I ever used it, it does look outdated, so I won't miss it.
If it has upstream repo somewhere, we could put a reference in commit
message.



> It's not in any runtest file thus not being run by default.
>
> I'd either delete it. Or, if still useful, I'd put it into separate project
> under https://github.com/linux-test-project.
>
> Kind regards,
> Petr
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210604/ed79e6f7/attachment.htm>
