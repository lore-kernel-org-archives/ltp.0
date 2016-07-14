From: Li Wang <liwang@redhat.com>
Date: Thu, 14 Jul 2016 16:03:11 +0800
Subject: [LTP] [PATCH] lib: add tst_read_meminfo / tst_get_avail_mem
In-Reply-To: <57863E28.7020309@redhat.com>
References: <cad01181438a055f45b32fc28b33a8b8da74b768.1465903335.git.jstancek@redhat.com>
 <CAEemH2fGEGXftvF_HttR18KSbp8YRL_zaMhb38MQ4cpXqr-fMg@mail.gmail.com>
 <1589618283.6491776.1465976075619.JavaMail.zimbra@redhat.com>
 <57614F55.9090407@redhat.com> <20160616052544.GA18852@gmail.com>
 <1809783770.6955910.1466060898915.JavaMail.zimbra@redhat.com>
 <20160713093505.GA6033@gmail.com> <57863E28.7020309@redhat.com>
Message-ID: <20160714080311.GA18082@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Jul 13, 2016 at 03:12:08PM +0200, Jan Stancek wrote:
> 
> Latest idea attached.
> 
> It's similar to SAFE_FILE_SCANF, but it scanfs each line and first
> matching all scanf directives wins and terminates search, otherwise
> you get non-zero ret code. For example:
> 
> if (SAFE_FILE_LINES_SCANF("/proc/meminfo", "MemFree: %ld", &free))
>         tst_brk(TBROK, "Could not parse MemFree");

I like this method! And I tend to think that we probably need achive two
macors for different occasions. In fact as the FILE_SCANF() do that.

FILE_LINES_SCANF() and SAFE_FILE_LINES_SCANF()


Regards,
Li Wang
