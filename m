From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 27 Apr 2021 12:58:16 +0200
Subject: [LTP] [PATCH 2/2] bpf: Check truncation on 32bit div/mod by zero
In-Reply-To: <YIfZqZ29H2AN1vqh@pevik>
References: <20210426120107.6632-1-rpalethorpe@suse.com>
 <20210426120107.6632-2-rpalethorpe@suse.com>
 <YIfZqZ29H2AN1vqh@pevik>
Message-ID: <YIfuSCLuEabBCfNN@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> /usr/src/ltp/docparse/testinfo.pl metadata.json
> , or ] expected while parsing array, at character offset 70801 (before "expected"",\n     "b...") at /usr/src/ltp/docparse/testinfo.pl line 423
> 
> Because we don't escap double quotes (among other issues previously reported,
> e.g. tabs), it produces invalid json:
> 
>    "doc": [
>      "[Description]",
>      "",
>      "Compare the effects of 32-bit div/mod by zero with the "expected"",
>      "behaviour.",
>      "",

This should be fairly easy to fix, we just need to replace the
data_printf() for strings in data_to_json_() with a function that would
generate the escapes.

Will you do that or should I prepare the patch?

-- 
Cyril Hrubis
chrubis@suse.cz
