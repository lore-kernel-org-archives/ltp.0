From: Vikas Kumar <Vikas.Kumar2@arm.com>
Date: Tue, 31 Mar 2020 10:48:16 +0000
Subject: [LTP] [PATCH 1/1] Added Refrence for Linux Asynchronous IO APIs
 in LTP
In-Reply-To: <20200331104256.GA12790@dell5510>
References: <20200313062058.7058-1-vikas.kumar2@arm.com>
 <20200313062058.7058-2-vikas.kumar2@arm.com>, <20200331104256.GA12790@dell5510>
Message-ID: <VI1PR08MB54862EB0A8D21C2C83545F23D1C80@VI1PR08MB5486.eurprd08.prod.outlook.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

Sure please go ahead with header and configure.ac changes.
I will post next set of V3 Patch changes on top of it.

Regards,
Vkas
________________________________
From: Petr Vorel <pvorel@suse.cz>
Sent: Tuesday, March 31, 2020 4:12 PM
To: Vikas Kumar <Vikas.Kumar2@arm.com>
Cc: ltp@lists.linux.it <ltp@lists.linux.it>; Anshuman Khandual <Anshuman.Khandual@arm.com>; viresh.kumar@linaro.org <viresh.kumar@linaro.org>
Subject: Re: [LTP] [PATCH 1/1] Added Refrence for Linux Asynchronous IO APIs in LTP

Hi Vikas,

we decided to take only header and configure.ac as these are valid parts and
good preparation steps. So I removed the test itself and also updated header to
reflect v5.6 changes.
I also dared to remove your Author: line (but kept copyright of course), as Jens
Axboe and other kernel developers are the authors :).

Kind regards,
Petr
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200331/8371167a/attachment.htm>
