From: Murphy Zhou <xzhou@redhat.com>
Date: Fri, 24 May 2019 21:44:12 +0800
Subject: [LTP] [PATCH v2 1/2] OVL_MNT: add setup_overlay helper
In-Reply-To: <20190524122357.GA28108@dell5510>
References: <20190503210005.GA18171@x230>
 <20190515092129.26336-1-xzhou@redhat.com>
 <20190515133102.GA5429@dell5510>
 <20190524043201.sxmkm6b7dixn2kuw@XZHOUW.usersys.redhat.com>
 <20190524085452.GB29592@dell5510>
 <CAOQ4uxhBcMRg1+7sihQaTC217We8Hj+fAQ2xhiDTHvBDP4NZag@mail.gmail.com>
 <20190524122357.GA28108@dell5510>
Message-ID: <20190524134412.xcc45ifc63cd5ypn@XZHOUW.usersys.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi guys,

Very good ideas! Thank you both very much!

M
On Fri, May 24, 2019 at 02:23:57PM +0200, Petr Vorel wrote:
> Hi Amir,
> 
> thanks for your suggestions, highly appreciated :).
> ...
> > > #define SAFE_MOUNT_OVERLAY() \
> > >         mount_overlay(__FILE__, __LINE__, 1);
> 
> > > #define TST_MOUNT_OVERLAY() \
> > >         mount_overlay(__FILE__, __LINE__, 0);
> 
> 
> > I like this version of the helpers/macros.
> 
> > I would change TST_MOUNT_OVERLAY to
> > (mount_overlay(__FILE__, __LINE__, 0) == 0)
> > so that it could be used like this:
> 
> > ovl_mounted = TST_MOUNT_OVERLAY(...)
> +1
> 
> > Uses of SAFE_MOUNT_OVERLAY() should not check return value
> > could even place (void) in front of mount_overlay to enforce that.
> If we don't care, then it could be?
> #define SAFE_MOUNT_OVERLAY() \
> 	(void) mount_overlay(__FILE__, __LINE__, 1);
> 
> I mean there is always mount_overlay() for special cases, macros should be
> here to make easier common usage.
> 
> > Test that use SAFE_MOUNT_OVERLAY() should either have no
> > variable ovl_mounted or set it after SAFE_MOUNT_OVERLAY() without
> > checking return value.
> +1
> 
> > Thanks,
> > Amir.
> 
> Kind regards,
> Petr
