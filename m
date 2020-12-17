From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 17 Dec 2020 13:20:34 +0100
Subject: [LTP] [PATCH 1/2] docparse/parse.sh: Fix parsing on dash
In-Reply-To: <20201217121520.25713-2-pvorel@suse.cz>
References: <20201217121520.25713-1-pvorel@suse.cz>
 <20201217121520.25713-2-pvorel@suse.cz>
Message-ID: <X9tNEoMlQsCaSZPD@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> bash keeps escape sequences (e.g. \t and \n) when using echo:
> 
> $ a="-v\tverbose output\n"; echo "$a"
> -v\tverbose output\n
> $
> 
> But dash interprets them (behaves like echo -e on bash):
> 
> $ a="-v\tverbose output\n"; echo -e "$a"
> -e -v	verbose output

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Can we remove the \t from the perf_event_open02.c as well please? I
doubt that it will do any good when we pass the strings into asciidoc
parser...

-- 
Cyril Hrubis
chrubis@suse.cz
