From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 20 Nov 2020 09:45:00 +0100
Subject: [LTP] [PATCH 1/1] net/traceroute01: Check also -T flag
In-Reply-To: <1d451c4a-6599-ac95-2b51-509fdd4c277a@oracle.com>
References: <20201112173609.4123-1-petr.vorel@suse.com>
 <20201119152300.05ef03b0@kmaincent-XPS-13-7390>
 <20201119154132.GA16438@pevik>
 <cf76949d-32a7-7b2d-4d5b-6117676ecea6@oracle.com>
 <20201119195618.GA3181@pevik>
 <1d451c4a-6599-ac95-2b51-509fdd4c277a@oracle.com>
Message-ID: <20201120084500.GA231208@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

...
> Hi Petr,

> traceroute6 127.0.0.1
> traceroute6: 127.0.0.1: Address family for hostname not supported

> And both ::1 and 127.0.0.1 are ok for traceroute without the address
> family option.

Thanks for an explanation!

> > BTW ack this change?


> Acked-by: Alexey Kodanev <alexey.kodanev@oracle.com>

Thanks! Merged.

Kind regards,
Petr
