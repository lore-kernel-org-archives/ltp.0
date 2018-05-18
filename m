From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 18 May 2018 09:30:39 +0800
Subject: [LTP] [PATCH 2/2] syscalls/prctl02: Rewrite to the new library
In-Reply-To: <20180517152329.3h7zuuoatcbtklbl@dell5510>
References: <1524106257-4711-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1524106257-4711-2-git-send-email-yangx.jy@cn.fujitsu.com>
 <20180517152329.3h7zuuoatcbtklbl@dell5510>
Message-ID: <5AFE2CBF.4010909@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

Thanks for your comment.
I will send v2 patch set as you suggested.

Thanks,
Xiao Yang
On 2018/05/17 23:23, Petr Vorel wrote:
> Hi Xiao,
>
> LGTM, with 2 very minor issues.
> If you're ok with them I can change it before merging.
>
>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
> Reviewed-by: Petr Vorel<pvorel@suse.cz>
>> ---
>>   testcases/kernel/syscalls/prctl/prctl02.c | 203 ++++++------------------------
> ...
>> + * This program is free software: you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation, either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program. If not, see<http://www.gnu.org/licenses/>.
>> + */
> Again, if you want, you can use SPDX license identifier (it's much shorter):
> // SPDX-License-Identifier: GPL-2.0-or-later
>
>> -struct test_cases_t {
>> +static struct test_cases_t {
> Using tcase would be shorter.
>
> ...
>> +	if (TEST_ERRNO == tc->exp_errno) {
> Can you please swap these to?
> if (tc->exp_errno == TEST_ERRNO) {
>> +		tst_res(TPASS | TTERRNO, "prctl() failed as expected");
>> +	} else {
>> +		tst_res(TPASS | TTERRNO, "prctl() failed unexpectedly, "
>> +			"expected %s", tst_strerrno(tc->exp_errno));
>> +	}
>>   }
> Kind regards,
> Petr
>
>
> .
>



