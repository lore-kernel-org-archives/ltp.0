From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 26 Nov 2015 14:59:24 +0100
Subject: [LTP] [PATCH v2] hugetlb/hugemmap: add new testcase hugemmap06.c
In-Reply-To: <5656CF53.3030409@oracle.com>
References: <1448506977-12479-1-git-send-email-liwang@redhat.com>
 <5656CF53.3030409@oracle.com>
Message-ID: <20151126135924.GB9276@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +		mmap_sz[i].sz = sz;
> > +		mmap_sz[i].addr = addr;
> > +
> > +		TEST(pthread_create(tid + i, NULL, thr, &mmap_sz[i]));
> 
> This is not right, use tid[i] ( = tid + sizeof(pthread_t) * i), not tid + i.

Hmm, since when arr + i != &arr[i] ?

When arr is pthread_t * type it's incremented by sizeof(pthread_t). As
far as I know arr[i] is just shorthand for *(arr + i). Which is a reason
why obscure things like i[arr] compile and give the same answer as
arr[i] even then technically the value is undefined.

If you want to increment pointer by 1 you have to explicitly cast it to
char * or intptr_t.

-- 
Cyril Hrubis
chrubis@suse.cz
