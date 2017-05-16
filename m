From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 16 May 2017 16:29:24 +0200
Subject: [LTP] [PATCH v2] move_pages12: Make sure hugepages are available
In-Reply-To: <364825081.12577806.1494944124022.JavaMail.zimbra@redhat.com>
References: <20170516100759.10355-1-chrubis@suse.cz>
 <1420231349.12458178.1494937684196.JavaMail.zimbra@redhat.com>
 <20170516133233.GB2897@rei.lan>
 <1571565362.12569976.1494943541160.JavaMail.zimbra@redhat.com>
 <364825081.12577806.1494944124022.JavaMail.zimbra@redhat.com>
Message-ID: <20170516142924.GE2897@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Correction: "hpsz / 1024", we multiply it in setup() by 1024.

I've moved the multiplication down in the setup so that we end up with
correct value without the divison. And I've also added you Signed-off-by
to the patch, since you did non-trivial amount of work on it and finally
pushed it. Thanks for you help.

Now I will tag the git, upload tarballs, etc...

-- 
Cyril Hrubis
chrubis@suse.cz
