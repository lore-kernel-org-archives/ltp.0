From: Chunyu Hu <chuhu@redhat.com>
Date: Fri, 18 Mar 2016 09:21:36 -0400 (EDT)
Subject: [LTP] [PATCH RFC 8/9] ftrace_stress: update the trace_options
 test
In-Reply-To: <20160317171859.GH31815@rei.lan>
References: <1457079898-9449-1-git-send-email-liwang@redhat.com>
 <1457079898-9449-4-git-send-email-liwang@redhat.com>
 <1457079898-9449-5-git-send-email-liwang@redhat.com>
 <1457079898-9449-6-git-send-email-liwang@redhat.com>
 <1457079898-9449-7-git-send-email-liwang@redhat.com>
 <1457079898-9449-8-git-send-email-liwang@redhat.com>
 <1457079898-9449-9-git-send-email-liwang@redhat.com>
 <20160317171859.GH31815@rei.lan>
Message-ID: <2011167372.29659341.1458307296905.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Li Wang" <liwang@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Friday, March 18, 2016 1:19:00 AM
> Subject: Re: [LTP] [PATCH RFC 8/9] ftrace_stress: update the trace_options test
> 
> Hi!
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
> 
> The portable way is plain old wc:
> 
> NR=$(echo $trace_options |wc -w)

Will take this way in V2, thanks for the suggestion.

In fact i made it to an array. But i will make trace_options to a string in V2.
As you mentioned, some other shells may not recognize the bash style array. Thanks !


> >  for ((; ; ))
> >  {
> 
> Please fix these bash style loops as well.

Will do it in V2. Thanks.

> > @@ -25,7 +31,6 @@ for ((; ; ))
> >  	{
> >  		num=`date +%N`
> >  		num=`printf 1%s $num`
> > -
> >  		for ((i = 0; i < $NR_TRACE_OPTIONS; i++))
> >  		{
> 
> And here.

Will modify this in V2. Thanks for reviewing this.

> >  			n=$(( ( $num >> $i ) % 2 ))
> > @@ -34,9 +39,9 @@ for ((; ; ))
> >  			else
> >  				echo 1 > "$TRACING_PATH"/options/${trace_options[$i]}
> >  			fi
> > +			[ $? -ne 0 ] && echo "setup trace option ${trace_options[$i]} failed"
> 
> Shouldn't this check be just after the echo rather than here?

Agree, the echo message is just for setting, but the clear branch can also hit this message.
So we need to make the message can express both set and the clear option failure.

> >  		}
> >  	}
> >  
> >  	sleep 1
> >  }
> > -
> > --
> > 1.8.3.1
> > 
> > 
> > --
> > Mailing list info: http://lists.linux.it/listinfo/ltp
> 
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

