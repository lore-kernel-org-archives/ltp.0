From: Chunyu Hu <chuhu@redhat.com>
Date: Fri, 18 Mar 2016 09:24:23 -0400 (EDT)
Subject: [LTP] [PATCH RFC 8/9] ftrace_stress: update the trace_options
 test
In-Reply-To: <20160317172851.GI31815@rei.lan>
References: <1457079898-9449-1-git-send-email-liwang@redhat.com>
 <1457079898-9449-5-git-send-email-liwang@redhat.com>
 <1457079898-9449-6-git-send-email-liwang@redhat.com>
 <1457079898-9449-7-git-send-email-liwang@redhat.com>
 <1457079898-9449-8-git-send-email-liwang@redhat.com>
 <1457079898-9449-9-git-send-email-liwang@redhat.com>
 <20160317171859.GH31815@rei.lan> <20160317172851.GI31815@rei.lan>
Message-ID: <658905562.29659743.1458307463377.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Li Wang" <liwang@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Friday, March 18, 2016 1:28:51 AM
> Subject: Re: [LTP] [PATCH RFC 8/9] ftrace_stress: update the trace_options test
> 
> Hi!
> > > +# enable the nop_test_refuse can cause an
> > > +# 'write error: Invalid argument'. So don't
> > > +# test it.
> > > +option_files=${option_files/test_nop_refuse/}
> > > +trace_options=( $option_files )
> > > +
> > > +NR_TRACE_OPTIONS=${#trace_options[*]}
> > 
> > This does not work even in bash because the trace_options is never
> > casted to array so it just returns 0.
> 
> My bad, it is converted by the ().
> 
> But the point is the same, use portable code.

Thanks for suggestion! Will make it a string in V2. 

> --
> Cyril Hrubis
> chrubis@suse.cz
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 

-- 
Regards,
Chunyu Hu

