From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 3 Nov 2017 14:04:28 +0100
Subject: [LTP] [PATCH v2] syscalls/request_key03: new test for key
 instantiation races
In-Reply-To: <20171102191354.24733-1-ebiggers3@gmail.com>
References: <20171102191354.24733-1-ebiggers3@gmail.com>
Message-ID: <20171103130428.GA22844@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
When I run the test as an ordinary user I got EDQUOT from add_key() from
time to time. So we either have to add .needs_root = 1 so that quotas
does not apply or change the test to ignore the EDQUOT as well while we
are adding the key.

Otherwise the test is OK.

-- 
Cyril Hrubis
chrubis@suse.cz
