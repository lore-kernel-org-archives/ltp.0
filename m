From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 13 Nov 2019 11:27:42 -0500 (EST)
Subject: [LTP] [PATCH] mkswap01.sh: Add "udevadm trigger" before swap
 verification
In-Reply-To: <2005122441.11970775.1573662156034.JavaMail.zimbra@redhat.com>
References: <20191112035237.39839-1-yongxin.liu@windriver.com>
 <2005122441.11970775.1573662156034.JavaMail.zimbra@redhat.com>
Message-ID: <81526046.11972982.1573662462115.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> 
> 
> ----- Original Message -----
> > diff --git a/testcases/commands/mkswap/mkswap01.sh
> > b/testcases/commands/mkswap/mkswap01.sh
> > index 3a348c6e6..9437c4a4e 100755
> > --- a/testcases/commands/mkswap/mkswap01.sh
> > +++ b/testcases/commands/mkswap/mkswap01.sh
> > @@ -129,6 +129,8 @@ mkswap_test()
> >  		return
> >  	fi
> >  
> > +	udevadm trigger --name-match=$TST_DEVICE
> 
> It's been many months since I looked at this,..
> Can you explain why this fixes it?
> 
> Don't we need "udevadm settle" as well to make sure udev caught up
> before we check result?

Ah, test is using TST_RETRY_FUNC, so udev should have time
to catch up. Please ignore my query.

Thanks,
Jan

