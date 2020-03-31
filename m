From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 31 Mar 2020 12:42:56 +0200
Subject: [LTP] [PATCH 1/1] Added Refrence for Linux Asynchronous IO APIs
 in LTP
In-Reply-To: <20200313062058.7058-2-vikas.kumar2@arm.com>
References: <20200313062058.7058-1-vikas.kumar2@arm.com>
 <20200313062058.7058-2-vikas.kumar2@arm.com>
Message-ID: <20200331104256.GA12790@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Vikas,

we decided to take only header and configure.ac as these are valid parts and
good preparation steps. So I removed the test itself and also updated header to
reflect v5.6 changes.
I also dared to remove your Author: line (but kept copyright of course), as Jens
Axboe and other kernel developers are the authors :).

Kind regards,
Petr
