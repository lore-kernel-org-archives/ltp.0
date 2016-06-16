From: Li Wang <liwang@redhat.com>
Date: Thu, 16 Jun 2016 15:32:10 +0800
Subject: [LTP] [PATCH] lib: add tst_read_meminfo / tst_get_avail_mem
In-Reply-To: <1809783770.6955910.1466060898915.JavaMail.zimbra@redhat.com>
References: <cad01181438a055f45b32fc28b33a8b8da74b768.1465903335.git.jstancek@redhat.com>
 <CAEemH2fGEGXftvF_HttR18KSbp8YRL_zaMhb38MQ4cpXqr-fMg@mail.gmail.com>
 <1589618283.6491776.1465976075619.JavaMail.zimbra@redhat.com>
 <57614F55.9090407@redhat.com> <20160616052544.GA18852@gmail.com>
 <1809783770.6955910.1466060898915.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2cQoP+zWq9w_Vgs6b-JhJziadcuLK-VU=M1rMwKr5z1yg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Jun 16, 2016 at 3:08 PM, Jan Stancek <jstancek@redhat.com> wrote:
>
> I'm now considering exposing just a parse function, I'd like to
> avoid having separate function for each proc file. And possibly
> more than one since those 2 proc files you mentioned don't have
> uniform format for all content.

Yes, achieve one parse function for whole proc files is unpractical.
IMO, we could take more consideration for the files frequently opened
in ltp general test.

Regards,
Li Wang
