From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 30 Aug 2019 16:48:10 +0200
Subject: [LTP] [PATCH v3 1/2] capability: Introduce capability API
In-Reply-To: <20190829210810.GC5711@dell5510>
References: <20190823094621.21747-1-rpalethorpe@suse.com>
 <CAEemH2dVf66_sKT4iBSEOXg+yFhpL7mAp4Uar5OT6vmbiMa0ZQ@mail.gmail.com>
 <871rx5mrhr.fsf@rpws.prws.suse.cz> <20190829210810.GC5711@dell5510>
Message-ID: <20190830144810.GA25654@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> There is a warning, but I guess that's just gcc being paranoid:
> test_guarded_buf.c:93:1: warning: missing initializer for field ???caps??? of ???struct tst_test??? [-Wmissing-field-initializers]
>    93 | };
>       | ^
> In file included from test_guarded_buf.c:12:
> ../../include/tst_test.h:214:18: note: ???caps??? declared here
>   214 |  struct tst_cap *caps;
>       |                  ^~~~

That sounds like a gcc bug since for designated initializers omitted
fields are implicitly initialized to zero, there is no point in
producing warnings like this one. I guess that we trigger that by
inlining a structure that is inialized by mixing plain and designated
initalizers in the middle of the structure.

-- 
Cyril Hrubis
chrubis@suse.cz
