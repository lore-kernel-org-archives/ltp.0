From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 26 Apr 2018 17:28:30 +0300
Subject: [LTP] [PATCH] commands: Remove all test cases
In-Reply-To: <20180426132418.19495-2-schlad@suse.de>
References: <20180426132418.19495-1-schlad@suse.de>
 <20180426132418.19495-2-schlad@suse.de>
Message-ID: <b72b277b-e8e0-d69c-b918-bd48341c2a1d@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 04/26/2018 04:24 PM, Sebastian Chlad wrote:
> Test cases testing commands are often outdated or not maintained.
> Those test cases also do not fit in with current LTP project status.
> 
> Signed-off-by: Sebastian Chlad <schlad@suse.de>
> ---

Hi Sebastian,

...

> diff --git a/testcases/commands/keyctl/keyctl01.sh b/testcases/commands/keyctl/keyctl01.sh
> deleted file mode 100644
> index 3fda3893b..000000000
> --- a/testcases/commands/keyctl/keyctl01.sh
> +++ /dev/null
> @@ -1,126 +0,0 @@
> -#!/bin/sh
> -#
> -# Copyright (c) 2017 Fujitsu Ltd.
> -# Ported: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
> -#
> -# This program is free software; you can redistribute it and/or modify
> -# it under the terms of the GNU General Public License as published by
> -# the Free Software Foundation; either version 2 of the License, or
> -# (at your option) any later version.
> -#
> -# This program is distributed in the hope that it would be useful,
> -# but WITHOUT ANY WARRANTY; without even the implied warranty of
> -# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> -# GNU General Public License for more details.
> -#
> -# You should have received a copy of the GNU General Public License
> -# along with this program, if not, see <http://www.gnu.org/licenses/>.
> -#
> -# This is a regression test about potential uninitialized variable,
> -# the test can crash the buggy kernel, and the bug has been fixed in:
> -#
> -#   commit 38327424b40bcebe2de92d07312c89360ac9229a
> -#   Author: Dan Carpenter <dan.carpenter@oracle.com>
> -#   Date:   Thu Jun 16 15:48:57 2016 +0100
> -#
> -#   KEYS: potential uninitialized variable
> -#

...

> diff --git a/testcases/commands/sysctl/sysctl01.sh b/testcases/commands/sysctl/sysctl01.sh
> deleted file mode 100755
> index 7522da53d..000000000
> --- a/testcases/commands/sysctl/sysctl01.sh
> +++ /dev/null
> @@ -1,55 +0,0 @@
> -#!/bin/sh
> -
> -# Copyright (c) 2018 FUJITSU LIMITED. All rights reserved.
> -# Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
> -#
> -# This program is free software;  you can redistribute it and#or modify
> -# it under the terms of the GNU General Public License as published by
> -# the Free Software Foundation; either version 2 of the License, or
> -# (at your option) any later version.
> -#
> -# This program is distributed in the hope that it will be useful, but
> -# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
> -# or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
> -# for more details.
> -#
> -# You should have received a copy of the GNU General Public License
> -# along with this program; if not, see <http://www.gnu.org/licenses/>.
> -#
> -# Description:
> -# This is a regression test for invalid value of sysctl_sched_time_avg.
> -# System will hang if user set sysctl_sched_time_avg to 0 on buggy kernel.
> -#
> -# The kernel bug has been fixed in kernel:
> -# '5ccba44ba118("sched/sysctl: Check user input value of sysctl_sched_time_avg")'
> -

And those tests also don't fit?
