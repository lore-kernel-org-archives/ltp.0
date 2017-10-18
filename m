From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 18 Oct 2017 12:09:20 +0200
Subject: [LTP] [RFC] [PATCH 1/2] lib: Add tst_strstatus()
In-Reply-To: <59E48986.5080608@cn.fujitsu.com>
References: <20171012153338.1233-1-chrubis@suse.cz>
 <59E48986.5080608@cn.fujitsu.com>
Message-ID: <20171018100920.GA25433@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > diff --git a/lib/newlib_tests/test_str_status.c b/lib/newlib_tests/test_str_status.c
> > new file mode 100644
> > index 000000000..706ec1144
> > --- /dev/null
> > +++ b/lib/newlib_tests/test_str_status.c
> > @@ -0,0 +1,49 @@
> > +/*
> > + * Copyright (c) 2016 Cyril Hrubis<chrubis@suse.cz>
> Hi Cyril,
> 
> The correct date is 2017 here.
> 

Ah right, and the top level comment in the test is wrong as well, will
fix that.

-- 
Cyril Hrubis
chrubis@suse.cz
