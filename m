From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Fri, 29 Sep 2017 13:08:47 +0200
Subject: [LTP] [PATCH v3] Add test for CVE-2017-7308 on a raw socket's
	ring buffer
In-Reply-To: <20170913150514.GB29584@rei.lan>
References: <20170911132233.19658-1-rpalethorpe@suse.com>
 <20170913150514.GB29584@rei.lan>
Message-ID: <87d169wym8.fsf@our.domain.is.not.set>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Cyril Hrubis writes:

> Hi!
>> diff --git a/m4/ltp-tpacket-v3.m4 b/m4/ltp-tpacket-v3.m4
>> new file mode 100644
>> index 000000000..fce2e0ebf
>> --- /dev/null
>> +++ b/m4/ltp-tpacket-v3.m4
>> @@ -0,0 +1,22 @@
>> +dnl Copyright (c) 2017 Richard Palethorpe <rpalethorpe@suse.com>
>> +dnl
>> +dnl This program is free software;  you can redistribute it and/or modify
>> +dnl it under the terms of the GNU General Public License as published by
>> +dnl the Free Software Foundation; either version 2 of the License, or
>> +dnl (at your option) any later version.
>> +dnl
>> +dnl This program is distributed in the hope that it will be useful,
>> +dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
>> +dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
>> +dnl the GNU General Public License for more details.
>> +dnl
>> +dnl You should have received a copy of the GNU General Public License
>> +dnl along with this program. If not, see <http://www.gnu.org/licenses/>.
>> +
>> +AC_DEFUN([LTP_CHECK_TPACKET_V3],[
>> +AC_CHECK_TYPES([struct tpacket_req3],,,[
>> +#ifdef HAVE_LINUX_IF_PACKET_H
>> +# include <linux/if_packet.h>
>> +#endif
>
> Do we really need these ifdefs here? Wouldn't the check fail anyway in
> a case that the header is ifdefed out?
>
> Or does autoconf break somehow if the header couldn't be included?
>

It is just what the AC documentation recommends, although I can't
remember why or where I read it. Possibly it is preferred for
compilation to fail rather than the pre-processor. 

-- 
Thank you,
Richard.
