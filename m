From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 17 Jan 2017 16:43:13 +0100
Subject: [LTP] utimensat EACCES vs. EPERM in 4.8+
In-Reply-To: <CAOssrKd32K-e5794m9KOjrMm_E3VZ7P-bvZW2P8UpGFTOgi8JQ@mail.gmail.com>
References: <18a5b416-ad6a-e679-d993-af7ffa0dcc10@redhat.com>
 <CAOssrKfb1-C8c=9bAPiairh+Lyf=w28r+RjSXTLQcQZ-=eWMRA@mail.gmail.com>
 <CAKgNAkjTkBMY0wrj3wsH39YF=bHp=8mbYrXkSPzn0X4ezfso1w@mail.gmail.com>
 <280513509.810300.1484639500985.JavaMail.zimbra@redhat.com>
 <20170117075702.GB10417@rei.lan>
 <CAOssrKd32K-e5794m9KOjrMm_E3VZ7P-bvZW2P8UpGFTOgi8JQ@mail.gmail.com>
Message-ID: <20170117154312.GB28074@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Actually credit goes to SUSE QAM that caught the change on kernel
> > update :-).
> 
> And while this makes for a nice discussion, it is almost completely
> irrelevant in real life, since the only thing broken by this change
> will be test suites (in other words immutable files are rare as hen's
> teeth).

We do have documentation and code out of sync so this is a valid bug
regardless of which one of them ends up fixed in the end...

-- 
Cyril Hrubis
chrubis@suse.cz
