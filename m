From: Miklos Szeredi <mszeredi@redhat.com>
Date: Tue, 17 Jan 2017 10:39:37 +0100
Subject: [LTP] utimensat EACCES vs. EPERM in 4.8+
In-Reply-To: <20170117075702.GB10417@rei.lan>
References: <18a5b416-ad6a-e679-d993-af7ffa0dcc10@redhat.com>
 <CAOssrKfb1-C8c=9bAPiairh+Lyf=w28r+RjSXTLQcQZ-=eWMRA@mail.gmail.com>
 <CAKgNAkjTkBMY0wrj3wsH39YF=bHp=8mbYrXkSPzn0X4ezfso1w@mail.gmail.com>
 <280513509.810300.1484639500985.JavaMail.zimbra@redhat.com>
 <20170117075702.GB10417@rei.lan>
Message-ID: <CAOssrKd32K-e5794m9KOjrMm_E3VZ7P-bvZW2P8UpGFTOgi8JQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Jan 17, 2017 at 8:57 AM, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
>> > Jan, thanks for spotting this.
>>
>> Credit goes to Cyril. As for LTP-20170116 (released yesterday) we went
>> with current documented behavior - few failures are expected on 4.8+.
>
> Actually credit goes to SUSE QAM that caught the change on kernel
> update :-).

And while this makes for a nice discussion, it is almost completely
irrelevant in real life, since the only thing broken by this change
will be test suites (in other words immutable files are rare as hen's
teeth).

If you find that this change actually breaks something other than a
test suite, then yes, please lets revert it.  Otherwise there's not
much point (distros can revert it for themselves if they want be
paranoid).

Thanks,
Miklos
