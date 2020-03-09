From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 9 Mar 2020 09:28:49 +0100
Subject: [LTP] [PATCH v1 2/2] syscalls/settimeofday02: convert to new
 library
In-Reply-To: <fd1bed86-4590-cf73-a121-b9f9f0271e13@cn.fujitsu.com>
References: <1583311467-2379-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1583311467-2379-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200309074701.GA299736@x230>
 <fd1bed86-4590-cf73-a121-b9f9f0271e13@cn.fujitsu.com>
Message-ID: <20200309082849.GA322685@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

> > > +static void verify_settimeofday(unsigned int n)
> > ...
> > > +	struct tcase *tc = &tcases[n];
> > > +
> > > +	flag = 0;
> > > +	tst_res(TINFO, "%s", tc->message);
> > > +	TEST(settimeofday(&tc->tv, NULL));
> > > +	if (TST_RET != -1) {
> > > +		tst_res(TFAIL, "settimeofday() succeeded unexpectedly");
> > Maybe add TTERRNO here as well?
> Why? When run into here, settimeofyday succeeded unexpectedly, errno should
> be 0.
Correct. I'm sorry, I read != as ==.

Kind regards,
Petr
