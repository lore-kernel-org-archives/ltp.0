From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Thu, 09 Nov 2017 09:29:18 +0100
Subject: [LTP] [PATCH] syscalls/add_key04: new test for associative
	array bug
In-Reply-To: <20171108211123.94429-1-ebiggers3@gmail.com>
References: <20171108211123.94429-1-ebiggers3@gmail.com>
Message-ID: <871sl7q2ht.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Eric,

Eric Biggers writes:

> From: Eric Biggers <ebiggers@google.com>
>
> Add a test for a bug in the kernel's generic associative array
> implementation which allowed users to cause a kernel oops (NULL pointer
> dereference) by adding keys to a keyring in a certain pattern.
>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  runtest/cve                                   |  1 +
>  runtest/syscalls                              |  1 +
>  testcases/kernel/syscalls/.gitignore          |  1 +
>  testcases/kernel/syscalls/add_key/add_key04.c | 90 +++++++++++++++++++++++++++
>  4 files changed, 93 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/add_key/add_key04.c
>
> diff --git a/runtest/cve b/runtest/cve
> index 1b0d13374..2873df906 100644
> --- a/runtest/cve
> +++ b/runtest/cve
> @@ -20,6 +20,7 @@ cve-2017-6951 cve-2017-6951
>  cve-2017-7308 setsockopt02
>  cve-2017-7472 keyctl04
>  cve-2017-12192 keyctl07
> +cve-2017-12193 add_key04
>  cve-2017-15274 add_key02
>  cve-2017-15299 request_key03 -b cve-2017-15299
>  cve-2017-15537 ptrace07
> diff --git a/runtest/syscalls b/runtest/syscalls
> index fc381eb16..14089ac2c 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -14,6 +14,7 @@ acct01 acct01
>  add_key01 add_key01
>  add_key02 add_key02
>  add_key03 add_key03
> +add_key04 add_key04
>  
>  adjtimex01 adjtimex01
>  adjtimex02 adjtimex02
> diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
> index 0b3935880..12a136edb 100644
> --- a/testcases/kernel/syscalls/.gitignore
> +++ b/testcases/kernel/syscalls/.gitignore
> @@ -9,6 +9,7 @@
>  /add_key/add_key01
>  /add_key/add_key02
>  /add_key/add_key03
> +/add_key/add_key04
>  /adjtimex/adjtimex01
>  /adjtimex/adjtimex02
>  /alarm/alarm01
> diff --git a/testcases/kernel/syscalls/add_key/add_key04.c b/testcases/kernel/syscalls/add_key/add_key04.c
> new file mode 100644
> index 000000000..78f9701f1
> --- /dev/null
> +++ b/testcases/kernel/syscalls/add_key/add_key04.c
> @@ -0,0 +1,90 @@
> +/*
> + * Copyright (c) 2017 Google, Inc.
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program, if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +/*
> + * Regression test for commit ea6789980fda ("assoc_array: Fix a buggy
> + * node-splitting case"), or CVE-2017-12193.
> + *
> + * Reproducing this bug requires adding keys to a keyring in a certain way that
> + * triggers a corner case in the kernel's "associative array" implementation,
> + * which is the data structure used to hold keys in a keyring, indexed by type
> + * and description.
> + *
> + * Specifically, the root node of a keyring's associative associative array must
                                                             ^
                                                     Is this a typo?

-- 
Thank you,
Richard.
