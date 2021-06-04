From: Enji Cooper <yaneurabeya@gmail.com>
Date: Fri, 4 Jun 2021 10:42:27 -0700
Subject: [LTP] [RFC] Remove disktest from LTP
In-Reply-To: <CAASaF6yHHty1m+1U-buHUt4P80fnoTqXTaSO7G-YBm=REWZyWw@mail.gmail.com>
References: <YLh9jvI/p/VxsSmx@pevik>
 <CAASaF6yHHty1m+1U-buHUt4P80fnoTqXTaSO7G-YBm=REWZyWw@mail.gmail.com>
Message-ID: <656D3EBA-5A3C-45F5-84B0-1427CE69C1F2@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


> On Jun 4, 2021, at 10:12 AM, Jan Stancek <jstancek@redhat.com> wrote:
> 
> 
> 
> On Thu, Jun 3, 2021 at 8:58 AM Petr Vorel <pvorel@suse.cz <mailto:pvorel@suse.cz>> wrote:
> Hi,
> 
> does anybody use testcases/kernel/io/disktest ?
> 
> It supports various OS, but not sure if it's relevant now in SSD era.
> Last update was in 2008 (version 1.4.2).
> 
> I don't think I ever used it, it does look outdated, so I won't miss it.
> If it has upstream repo somewhere, we could put a reference in commit message.

I say nuke it from orbit.

It exists in VCS still, so if someone wants to restore it and work on it, they can go back through the git history and do so.

Cheers,
-Enji
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210604/f34ae6c8/attachment.htm>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: Message signed with OpenPGP
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210604/f34ae6c8/attachment.sig>
