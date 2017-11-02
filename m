From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 2 Nov 2017 14:56:13 +0100
Subject: [LTP] [PATCH v8] Add test for CVE-2017-7308 on a raw socket's
 ring buffer
In-Reply-To: <20171102134406.22929-1-rpalethorpe@suse.com>
References: <20171102134406.22929-1-rpalethorpe@suse.com>
Message-ID: <20171102135613.GA19581@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  setsockopt01 setsockopt01
> -cve-2016-4997 cve-2016-4997
> +setsockopt02 setsockopt02

Huh, even in a case that we want to remove the cve-2016-4997 from the
runtest file here it should be done in a separate patch.

-- 
Cyril Hrubis
chrubis@suse.cz
