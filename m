From: Li Wang <liwang@redhat.com>
Date: Mon, 13 Apr 2020 14:21:04 +0800
Subject: [LTP] [PATCH] ltp_tpci.c: fix a null pointer
In-Reply-To: <85165f62-1148-aead-30dc-8a23aeb19c96@cn.fujitsu.com>
References: <1584507302-23515-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <bd1dc27b-5680-5a7e-941e-bbd085880ffa@linux.ibm.com>
 <85165f62-1148-aead-30dc-8a23aeb19c96@cn.fujitsu.com>
Message-ID: <CAEemH2fQxooTB7tXkKSSO5ZSRUY2AmuKMCmMaUE+wTn-zq1odQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Yang Xu <xuyang2018.jy@cn.fujitsu.com> wrote:

...
> > I was about to post the same fix on the mailing list - just tested in
> > powerpc arch and it looks good to me.
> >
> > It is safe to use 0 since function pci_get_bus_and_slot(unsigned int
> > bus, unsigned int devfn) removed on kernel commit <5cf0c37a71da0f3>
> > ("PCI: Remove pci_get_bus_and_slot() function") used to be a wrapper for
> > pci_get_domain_bus_and_slot(0, bus, devfn).
>


> Sorry for the late reply. Thanks for your review. I think this should be
> added into commit message, so make this fix more clear.
>

I helped to add the hint messages and pushed. Thanks for your fix/review.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200413/347b917f/attachment.htm>
