Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Z2HXl-00074C-PR
	for ltp-list@lists.sourceforge.net; Tue, 09 Jun 2015 11:18:09 +0000
Date: Tue, 9 Jun 2015 13:17:05 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150609111705.GA25408@rei.suse.de>
References: <1433253418-44054-1-git-send-email-liaoqingwei@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1433253418-44054-1-git-send-email-liaoqingwei@huawei.com>
Subject: Re: [LTP] [PATCH] rpc/basic_tests/rpc01:Fix the error parameters
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Liao Qingwei <liaoqingwei@huawei.com>
Cc: ltp-list@lists.sourceforge.net, dingguofu@huawei.com, zhanyongming@huawei.com

Hi!
>  	for (i = 0, p = buffer.data; i < buffer.data_length; i++, p++)
>  		*p = getc(fp);
>  	fclose(fp);
>  
> +	return_buffer = malloc(buffer.data_length);
> +	if (!return_buffer) {
> +		fprintf(stderr, "malloc failed for return_buffer\n");
> +		free(buffer.data);
> +		exit(1);
> +	}
> +
>  	rc = callrpc(server, program, version, 1, (xdrproc_t)xdr_send_data,
> -			(char *)&buffer, (xdrproc_t)xdr_receive_data,
> -			(char *)&return_buffer);
> -	do_compare(rc, "callrpc", &buffer, return_buffer->data);
> +			buffer.data, (xdrproc_t)xdr_receive_data,
> +			return_buffer);
> +	do_compare(rc, "callrpc", &buffer, return_buffer);

As far as I can see the struct buffer is allocated in the
xdr_receive_data function in lib/librpc01.c.

So passing a pointer to a pointer to the struct buffer is right thing to
do here.

Or am I mistaken?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
