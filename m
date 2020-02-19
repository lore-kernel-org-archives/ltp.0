From: Li Wang <liwang@redhat.com>
Date: Wed, 19 Feb 2020 12:02:02 +0800
Subject: [LTP] [PATCH v4 1/2] lib: add .request_hugepages to reserve
 hugepage
In-Reply-To: <20200218162739.GA9985@rei.lan>
References: <20200208092014.24824-1-liwang@redhat.com>
 <20200218162739.GA9985@rei.lan>
Message-ID: <CAEemH2c1KJnBEizhB6_7Hqnkryg2QdhKeiWeZEc7oorPvmjgnQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Cyril Hrubis <chrubis@suse.cz> wrote:

...
> > +
> > +             mem_avail = SAFE_READ_MEMINFO("MemFree:");
> > +     }
>
> I guess that we don't have to bother with MemAvailable here, since we do
> drop the system caches the MemFree should be equal to MemAvailable. So I
> would be for reading just MemFree unconditionally here.
>

+1 yes, that's right.


> If you agree with this change I can change it before applying.
>

Of course yes, feel free to do that (and remember to add the changes which
Petr suggested).

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200219/ecf02c99/attachment.htm>
