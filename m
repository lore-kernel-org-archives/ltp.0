From: Enji Cooper <yaneurabeya@gmail.com>
Date: Fri, 4 Jun 2021 13:53:40 -0700
Subject: [LTP] [RFC] Remove disktest from LTP
In-Reply-To: <YLqEGb/fWiGJDI6z@pevik>
References: <YLh9jvI/p/VxsSmx@pevik>
 <CAASaF6yHHty1m+1U-buHUt4P80fnoTqXTaSO7G-YBm=REWZyWw@mail.gmail.com>
 <656D3EBA-5A3C-45F5-84B0-1427CE69C1F2@gmail.com> <YLqEGb/fWiGJDI6z@pevik>
Message-ID: <2049AE25-BA87-4E1E-8429-E6506107B8F7@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


> On Jun 4, 2021, at 12:50 PM, Petr Vorel <pvorel@suse.cz> wrote:
> 
> Hi Enji,
> 
>>> does anybody use testcases/kernel/io/disktest ?
> 
>>> It supports various OS, but not sure if it's relevant now in SSD era.
>>> Last update was in 2008 (version 1.4.2).
> 
>>> I don't think I ever used it, it does look outdated, so I won't miss it.
>>> If it has upstream repo somewhere, we could put a reference in commit message.
> 
>> I say nuke it from orbit.
> 
>> It exists in VCS still, so if someone wants to restore it and work on it, they can go back through the git history and do so.
> 
> I have not found the original project in sourceforge. Would you please post a
> link, I'll add it to the commit message of the removal commit.

I honestly don?t know where it came from :/?

My comment was more the fact that it exists in the LTP github repo, which means (even after it?s deleted), it can be restored.

Cheers,
-Enji
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: Message signed with OpenPGP
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210604/54b8d454/attachment.sig>
