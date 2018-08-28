From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 28 Aug 2018 06:19:40 -0400 (EDT)
Subject: [LTP] [PATCH] syscalls/move_pages: move_pages() can return
 positive value
In-Reply-To: <20180828100008.GA14275@rei.lan>
References: <15602db6c7187069f12f06cac46d06e1b715bbb9.1535376449.git.jstancek@redhat.com>
 <20180828100008.GA14275@rei.lan>
Message-ID: <1957638804.43116794.1535451580327.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Hi!
> >  		ret = numa_move_pages(0, TEST_PAGES, pages, NULL, status, 0);
> > -		if (ret != 0) {
> > +		if (ret == -1) {
> 
> Maybe we should go for (ret < 0) but other than that this looks good.

Agreed, we don't check for other negative values, so we better report
those as failures too.

Jan

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
