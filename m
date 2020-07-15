From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 15 Jul 2020 07:13:50 -0400 (EDT)
Subject: [LTP] [PATCH] tst_timer: pass kernel_timer_t type to syscalls
In-Reply-To: <20200715093312.5dbxlmkmolrha5vd@vireshk-i7>
References: <bd80f928abee6dac85d051c022afe559f5da8d0a.1594758146.git.jstancek@redhat.com>
 <20200715093312.5dbxlmkmolrha5vd@vireshk-i7>
Message-ID: <467071970.2954506.1594811630753.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> On 14-07-20, 22:24, Jan Stancek wrote:
> > timer_[gs]etttime tests are failing on s390, which is big endian
> > system, because tests are passing timer_t type, which is glibc
> > type (void *). Kernel expects and sets only int portion, so the
> > tests fail for all but first (0) timer id.

Pushed.

