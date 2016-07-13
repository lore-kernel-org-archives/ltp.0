From: Li Wang <liwang@redhat.com>
Date: Wed, 13 Jul 2016 17:35:05 +0800
Subject: [LTP] [PATCH] lib: add tst_read_meminfo / tst_get_avail_mem
In-Reply-To: <1809783770.6955910.1466060898915.JavaMail.zimbra@redhat.com>
References: <cad01181438a055f45b32fc28b33a8b8da74b768.1465903335.git.jstancek@redhat.com>
 <CAEemH2fGEGXftvF_HttR18KSbp8YRL_zaMhb38MQ4cpXqr-fMg@mail.gmail.com>
 <1589618283.6491776.1465976075619.JavaMail.zimbra@redhat.com>
 <57614F55.9090407@redhat.com> <20160616052544.GA18852@gmail.com>
 <1809783770.6955910.1466060898915.JavaMail.zimbra@redhat.com>
Message-ID: <20160713093505.GA6033@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Jan,

On Thu, Jun 16, 2016 at 03:08:18AM -0400, Jan Stancek wrote:
> 
> I'm now considering exposing just a parse function, I'd like to
> avoid having separate function for each proc file. And possibly
> more than one since those 2 proc files you mentioned don't have
> uniform format for all content.

How is the parse function going?

As there comes more and more places need get_mem_avaliable(), my opinion
is that we can apply your walk_file_lines() patch first, and let the
/proc/meminfo could be read by this lib. Then if we need more proc/files info
in future, adding new separate function is also accepted.

After all, we had discussed that one parse function for each proc file
is very hard to achive.

Regards,
Li Wang
