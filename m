From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 20 Apr 2018 13:02:49 +0200
Subject: [LTP] [RFC PATCH v3 05/10] ima/ima_boot_aggregate: Increase
 MAX_EVENT_SIZE to 1MB
In-Reply-To: <20180419195503.7194-6-pvorel@suse.cz>
References: <20180419195503.7194-1-pvorel@suse.cz>
 <20180419195503.7194-6-pvorel@suse.cz>
Message-ID: <20180420110248.GB19090@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	event.data = (char *) malloc(MAX_EVENT_DATA_SIZE);
                        ^
		Please never cast return value from malloc() in	C.

The malloc returns void* which is compatible with any other pointer type
for assigments. This is only needed when you attempt to use malloc()
in C++, but that is not the case here.

-- 
Cyril Hrubis
chrubis@suse.cz
