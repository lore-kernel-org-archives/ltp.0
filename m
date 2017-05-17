From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 17 May 2017 04:21:41 -0400 (EDT)
Subject: [LTP] [PATCH v2] move_pages12: Make sure hugepages are available
In-Reply-To: <20170516142924.GE2897@rei.lan>
References: <20170516100759.10355-1-chrubis@suse.cz>
 <1420231349.12458178.1494937684196.JavaMail.zimbra@redhat.com>
 <20170516133233.GB2897@rei.lan>
 <1571565362.12569976.1494943541160.JavaMail.zimbra@redhat.com>
 <364825081.12577806.1494944124022.JavaMail.zimbra@redhat.com>
 <20170516142924.GE2897@rei.lan>
Message-ID: <817764035.13130169.1495009301177.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Hi!
> > Correction: "hpsz / 1024", we multiply it in setup() by 1024.
> 
> I've moved the multiplication down in the setup so that we end up with
> correct value without the divison. And I've also added you Signed-off-by
> to the patch, since you did non-trivial amount of work on it and finally
> pushed it. Thanks for you help.

I let the last version running over night. No issues on x86 and ppc64le
with 4 nodes. arm with 512M hugepages had small issue with int overflow,
I pushed a patch.

Regards,
Jan
