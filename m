From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 10 Dec 2018 13:38:57 +0100
Subject: [LTP] [PATCH 3/3] crypto/crypto_user01.c: new test for
 information leak bug
In-Reply-To: <20181206181814.85583-4-ebiggers@kernel.org>
References: <20181206181814.85583-1-ebiggers@kernel.org>
 <20181206181814.85583-4-ebiggers@kernel.org>
Message-ID: <20181210123857.GB9930@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +/*
> + * Copyright 2018 Google LLC
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

We started to adopt the SPDX licencse identifier instead of this license
text because it's shorter and machine parseable.

In this case it would shorten the license to:

// SPDX-License-Identifier: GPL-2.0-or-later
/*
 * Copyright 2018 Google LLC
 */


Other than the minor issues pointed out by ritchie and peter the code
looks good to me.

-- 
Cyril Hrubis
chrubis@suse.cz
