From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 17 Mar 2016 18:28:51 +0100
Subject: [LTP] [PATCH RFC 8/9] ftrace_stress: update the trace_options
 test
In-Reply-To: <20160317171859.GH31815@rei.lan>
References: <1457079898-9449-1-git-send-email-liwang@redhat.com>
 <1457079898-9449-2-git-send-email-liwang@redhat.com>
 <1457079898-9449-3-git-send-email-liwang@redhat.com>
 <1457079898-9449-4-git-send-email-liwang@redhat.com>
 <1457079898-9449-5-git-send-email-liwang@redhat.com>
 <1457079898-9449-6-git-send-email-liwang@redhat.com>
 <1457079898-9449-7-git-send-email-liwang@redhat.com>
 <1457079898-9449-8-git-send-email-liwang@redhat.com>
 <1457079898-9449-9-git-send-email-liwang@redhat.com>
 <20160317171859.GH31815@rei.lan>
Message-ID: <20160317172851.GI31815@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +# enable the nop_test_refuse can cause an
> > +# 'write error: Invalid argument'. So don't
> > +# test it.
> > +option_files=${option_files/test_nop_refuse/}
> > +trace_options=( $option_files )
> > +
> > +NR_TRACE_OPTIONS=${#trace_options[*]}
> 
> This does not work even in bash because the trace_options is never
> casted to array so it just returns 0.

My bad, it is converted by the ().

But the point is the same, use portable code.

-- 
Cyril Hrubis
chrubis@suse.cz
