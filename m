From: Li Wang <liwang@redhat.com>
Date: Thu, 28 Nov 2019 14:10:00 +0800
Subject: [LTP] [PATCH] tst_fill_fs: enhance the filesystem filling
 routine
In-Reply-To: <986ec24a-0318-8217-52eb-816bbec5fb75@suse.cz>
References: <20191119094156.20348-1-liwang@redhat.com>
 <1860355560.12961927.1574161647388.JavaMail.zimbra@redhat.com>
 <CAEemH2cN8qv_YpsFKJazcOKEvgfjXpacZOV_Er-0bjK86=6VpQ@mail.gmail.com>
 <c9d278e6-5700-6c16-019b-1770a6ede0ff@suse.cz>
 <CAEemH2dZCm5MVyhzWiFKVK-jt+UUw65u5CRFk-moUVUgpDHHWg@mail.gmail.com>
 <d76d2ad2-f302-3cd5-0c9f-5d96a6a4bd55@suse.cz>
 <986ec24a-0318-8217-52eb-816bbec5fb75@suse.cz>
Message-ID: <CAEemH2dnBv+9t=Pk0iX8r8sG06CgueByw1PXZD+61erQfX0uZQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Nov 27, 2019 at 10:29 PM Martin Doucha <mdoucha@suse.cz> wrote:

> Hello,
> here's something fun which I've discovered while playing with
> fallocate05 test on XFS:
> - fallocate(x blocks)
> - tst_fill_fs()
> - write(x blocks) - OK
> - write(1 block) - ENOSPC
> - fallocate(1 block) - OK
> - write(1 block) - OK
> - fallocate(1 block) - ENOSPC
>
> Somehow, fallocate() can find another free block on XFS which wasn't
> available to write() at first. But then that block becomes write()able.
>

That's interesting.

It does prove that an xfs filesystem can't be really fill full. As FS dev
says though a filesystem return -ENOSPC, after some internal bookkeeping,
flushing, then have space available again.

And that also means to increases FALLOCATE_SIZE is a wise way to avoid this
problem.


>
> --
> Martin Doucha   mdoucha@suse.cz
> QA Engineer for Software Maintenance
> SUSE LINUX, s.r.o.
> CORSO IIa
> Krizikova 148/34
> 186 00 Prague 8
> Czech Republic
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191128/5a04406e/attachment-0001.htm>
