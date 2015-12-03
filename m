From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 3 Dec 2015 17:08:29 +0100
Subject: [LTP] [PATCH 2/2] hugetlb: checking if hugepage is supported on
 target system
In-Reply-To: <1448612328-2094-2-git-send-email-liwang@redhat.com>
References: <1448612328-2094-1-git-send-email-liwang@redhat.com>
 <1448612328-2094-2-git-send-email-liwang@redhat.com>
Message-ID: <20151203160829.GB20797@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> -static void setup(void)
> +void setup(void)

This is wrong. What you should do instead is:

* Remove the cleanup() and setup() definitions from the header from lib/

* Change the getipckey() and getuserid() to have the callback pointer as
  their first parameter and pass the cleanup callback in the
  testcases.

-- 
Cyril Hrubis
chrubis@suse.cz
