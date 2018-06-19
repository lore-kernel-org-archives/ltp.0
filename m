From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 19 Jun 2018 08:06:25 -0400 (EDT)
Subject: [LTP] [PATCH 1/2] madvise: add MADV_WIPEONFORK/MADV_KEEPONFORK
 in madvise() test
In-Reply-To: <CAEemH2fFc8xs7jOTCzfvDi_r=d09r2p0+xcGzdXYMq3Q8ruGqw@mail.gmail.com>
References: <20180514092635.26100-1-liwang@redhat.com>
 <CAEemH2fFc8xs7jOTCzfvDi_r=d09r2p0+xcGzdXYMq3Q8ruGqw@mail.gmail.com>
Message-ID: <1285900742.27485939.1529409985621.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> ping
> 
> On Mon, May 14, 2018 at 5:26 PM, Li Wang < liwang@redhat.com > wrote:
> 
> 
> The kernel commit (d2cd9ed mm,fork: introduce MADV_WIPEONFORK)
> introduces two new advices for madvise() in kernel-v4.14. Here
> making LTP cover that test accordingly.
> 
> Signed-off-by: Li Wang < liwang@redhat.com >

Both pushed. I pushed an extra commit on top, to print
advice that is being tested in madvise02.

Thanks,
Jan
