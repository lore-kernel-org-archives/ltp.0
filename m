Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A2E1C369A2
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 17:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744134739; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=VgHtDAOy1fGYEjwRiDt5dxqarl4YOjqo+vmNPSiNTwA=;
 b=bnngbhpWhIWeoMzCrIXL5FAm3WzM06sQrKl2j/WOXPnWASwVEr4oNgTtaJjzfufIDki5i
 f2LEzVM88nxZwhyZ/1OhKHk2k1Z9Z8bPfGiWuYbqx/FH3S5SdV9cZNtBbXB9H5h2qhzAehn
 d7DU6m5j5uf7ZU+Pjc/HZ6oHKEubAvk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 786243CABDA
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 19:52:19 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6D7A23CABDA
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 19:51:57 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E3C7B600C9B
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 19:51:55 +0200 (CEST)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3913b539aabso3512232f8f.2
 for <ltp@lists.linux.it>; Tue, 08 Apr 2025 10:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1744134715; x=1744739515; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WFPBxwQFtOT9D3vY+6eqEyOn6cXg1wjR4NHjU7o4duo=;
 b=b8daCndoy6vZmvnaN/puEqp9/a15eUtCsUrirnT5gLblCHcKv4kSFCu0AOM8lb31fB
 Hg9StTaGeCyprm8HVThmYz+YfZHUCsSu3PBo7S4GjRPFZVjh1pB4rQIOa2uFce+6JEZA
 VxEIUYNZKgCHGD8SyT0jqsM0e6fadfEetef1FRCZYh/2ugpykuZbJXpyxbQCVmCuO/mS
 2ZIkTAL8OLGBsgFy5D8wx8BA2s6mKU/NtlpB0qZVbZ0pIi0mLrdzij3TKnmAEqs2Ko9E
 j2wACBnFuIV8K5P0my37OzetXl2JTstKLpXa9Q5JAcDHtX1arJvLruj23CvvUKsqXogN
 6PDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744134715; x=1744739515;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WFPBxwQFtOT9D3vY+6eqEyOn6cXg1wjR4NHjU7o4duo=;
 b=kqb0DznR+vsbwaYFGFdjvJAuQTPNt8LHvb9fdT5Q7wPMOQCIS2OE1bUlIqJGk/GaXn
 XYgOaLVaGO1+H0jHsKIvnkPgrTo54Ywsc749arCS0+Ks0m0ny/rynu5bx9vUaDdVYOUs
 QrMwvBTCmlxoErCZIX6uklLQZk9RMbDyunf7/MZNU+euM9jBOB6vD3b4iYA4jMWLbmdw
 N97E7NWqwdxBGmZRpuzKBR/s/cuy2YNhX4uWyPjitXYFamFeZjv+rOWNPy+bE0bbd3ch
 rlJU2az8XQdcEaLDgsEOVArSabxUH71UUvhIFnvJSjuWxkKBHBR6QURX8NPH/+CarMnQ
 1ajQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2EeUQyDv+FEwRFDmPexob5YD6/feODwLfNt5oGCJ1AIS0G2x+5F0B146aznVAL2Y+kmI=@lists.linux.it
X-Gm-Message-State: AOJu0YwPcgjRcoF75DPcFAVA6f8TIRzOeRdEx8Jyfwd3UKTe+l8tet2i
 ubDWzWRnpi0AJF0JTK1fwMArQAS3gP5xefeCZQmXstP+BCLVJB8vqlj1CRnmYDuDsVy5lHAWVdw
 P
X-Gm-Gg: ASbGncsGizPhq0shPp33SVVnKm+evIaa/WMbEBxzoqs15B6a9/9U871pnafRII50z9p
 4O5oDBDs+HAsvBzUBTLKKwBeWYlmy82Iu9LVD0PW5z4cr4wPqKQ8N5t0s7xOzEccvYb+HKFkHB6
 DWD9C5mbfhOYejpTUFnI5U/KnqcwZdOkg2+9d9pEp/x6rITHXAwqWd0Q6EKX5mbJNG6uBcHCehb
 0xP2kPTZbt+6Q54A63Hv5hg68XxhSxoKxoityxDgEPzP/MpxhCFX7SgqkbGgP0tHgp1d+lpwin0
 fUK3r1xkPRBpESyGrFiDjLB5ZhAGzbLhpewSr8MfVyPgmw2+LaXtzqwt0B+hkm4gSNKOjMxx3E9
 VrJHFTEbkmqZfWfec53FIaCcoDo3d+EhuJEBzxkCdlE/hA13xhnMABqoG4l1xI9qn/UBHqS/b+J
 UvUUtyEUA=
X-Google-Smtp-Source: AGHT+IGuAaKrCE7gSosWwoFgd2UYYTxf73VhAbX/BzszHTxvGeFuoWc4J/OQ9IRx7D5XVPKahn4rZA==
X-Received: by 2002:a05:6000:2284:b0:390:fbba:e64b with SMTP id
 ffacd0b85a97d-39d87ac6375mr118640f8f.31.1744134715007; 
 Tue, 08 Apr 2025 10:51:55 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f1a:ea00:b220:7501:321e:5c31?
 (p200300ef2f1aea00b2207501321e5c31.dip0.t-ipconnect.de.
 [2003:ef:2f1a:ea00:b220:7501:321e:5c31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301a727bsm15480346f8f.27.2025.04.08.10.51.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Apr 2025 10:51:54 -0700 (PDT)
Message-ID: <26e70901-f36b-4fe1-98ec-c586b4d7bc03@suse.com>
Date: Tue, 8 Apr 2025 19:51:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
References: <20250408161745.9757-1-chrubis@suse.cz>
Content-Language: en-US
In-Reply-To: <20250408161745.9757-1-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib/tlibio: Get rid of support for old UNIXes
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

this was something I was about to do with grofiles.c refactoring, but 
since it's pending for a year now and I can't find energies to put hands 
in that "mud", it's good to start from something.
Thanks for the patch.

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

On 4/8/25 18:17, Cyril Hrubis wrote:
> Removes support for obsolete UNIXes CRAY, sgi, etc.
>
> Also removes the UCLIBC ifdefs that disabled most of the code because
> aio is not supported on UCLIBC.
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>   lib/tlibio.c | 566 ++-------------------------------------------------
>   1 file changed, 14 insertions(+), 552 deletions(-)
>
> diff --git a/lib/tlibio.c b/lib/tlibio.c
> index ed82a85b4..451244525 100644
> --- a/lib/tlibio.c
> +++ b/lib/tlibio.c
> @@ -53,15 +53,6 @@
>    *  int  lio_read_buffer(int fd, int method, char *buffer, int size,
>    *						char **errmsg, long wrd);
>    *
> - *  #ifdef CRAY
> - *  int  lio_wait4asyncio(int method, int fd, struct iosw **statptr)
> - *  int  lio_check_asyncio(char *io_type, int size, struct iosw *status)
> - *  #endif
> - *  #ifdef sgi
> - *  int  lio_wait4asyncio(int method, int fd, aiocb_t *aiocbp)
> - *  int  lio_check_asyncio(char *io_type, int size, aiocb_t *aiocbp, int method)
> - *  #endif
> - *
>    *  int  lio_parse_io_arg1(char *string)
>    *  void lio_help1(char *prefix);
>    *
> @@ -78,12 +69,9 @@
>    *
>    */
>   
> -#ifdef __linux__
> -#ifndef _GNU_SOURCE
>   #define _GNU_SOURCE
> -#endif
>   #define _LARGEFILE64_SOURCE
> -#endif
> +
>   #include "config.h"
>   #include <stdio.h>
>   #include <ctype.h>
> @@ -98,20 +86,9 @@
>   #include <sys/file.h>
>   #include <signal.h>
>   #include <stdint.h>
> -#ifdef CRAY
> -#include <sys/secparm.h>
> -#include <sys/iosw.h>
> -#include <sys/listio.h>
> -#else
> -/* for linux or sgi */
>   #include <sys/uio.h>		/* readv(2)/writev(2) */
>   #include <string.h>
> -#endif
> -#if defined(__linux__) || defined(__sun) || defined(__hpux) || defined(_AIX)
> -#ifndef __UCLIBC__
>   #include <aio.h>
> -#endif
> -#endif
>   #include <stdlib.h>		/* atoi, abs */
>   
>   #include "tlibio.h"		/* defines LIO* macros */
> @@ -121,15 +98,6 @@
>   #define PATH_MAX	MAXPATHLEN
>   #endif
>   
> -#if 0				/* disabled until it's needed -- roehrich 6/11/97 */
> -#define BUG1_workaround	1	/* Work around a condition where aio_return gives
> -				 * a value of zero but there is no errno followup
> -				 * and the read/write operation actually did its
> -				 * job.   spr/pv 705244
> -				 */
> -#endif
> -
> -
>   /*
>    * Define the structure as used in lio_parse_arg1 and lio_help1
>    */
> @@ -546,23 +514,11 @@ int lio_write_buffer(int fd,		/* open file descriptor */
>   	char *io_type;		/* Holds string of type of io */
>   	int omethod = method;
>   	int listio_cmd;		/* Holds the listio/lio_listio cmd */
> -#ifdef  CRAY
> -	struct listreq request;	/* Used when a listio is wanted */
> -	struct iosw status, *statptr[1];
> -#else
> -	/* for linux or sgi */
>   	struct iovec iov;	/* iovec for writev(2) */
> -#endif
> -#if defined (sgi)
> -	aiocb_t aiocbp;		/* POSIX aio control block */
> -	aiocb_t *aiolist[1];	/* list of aio control blocks for lio_listio */
> -	off64_t poffset;	/* pwrite(2) offset */
> -#endif
> -#if defined(__linux__) && !defined(__UCLIBC__)
>   	struct aiocb aiocbp;	/* POSIX aio control block */
>   	struct aiocb *aiolist[1];	/* list of aio control blocks for lio_listio */
>   	off64_t poffset;	/* pwrite(2) offset */
> -#endif
> +
>   	/*
>   	 * If LIO_RANDOM bit specified, get new method randomly.
>   	 */
> @@ -580,39 +536,23 @@ int lio_write_buffer(int fd,		/* open file descriptor */
>   		*errmsg = Errormsg;
>   
>   	Rec_signal = Received_signal;	/* get the current number of signals received */
> -#if defined(sgi) || (defined(__linux__) && !defined(__UCLIBC__))
>   	Rec_callback = Received_callback;	/* get the current number of callbacks received */
> -#endif
>   
> -#ifdef  CRAY
> -	memset(&status, 0x00, sizeof(struct iosw));
> -	memset(&request, 0x00, sizeof(struct listreq));
> -	statptr[0] = &status;
> -#else
> -	/* for linux or sgi */
>   	memset(&iov, 0x00, sizeof(struct iovec));
>   	iov.iov_base = buffer;
>   	iov.iov_len = size;
> -#endif
> -#if defined(sgi) || (defined(__linux__) && !defined(__UCLIBC__))
> -#if defined(sgi)
> -	memset(&aiocbp, 0x00, sizeof(aiocb_t));
> -#else
> +
>   	memset(&aiocbp, 0x00, sizeof(struct aiocb));
> -#endif
> +
>   	aiocbp.aio_fildes = fd;
>   	aiocbp.aio_nbytes = size;
>   	aiocbp.aio_buf = buffer;
>   /*    aiocbp.aio_offset = lseek( fd, 0, SEEK_CUR ); -- set below */
>   	aiocbp.aio_sigevent.sigev_notify = SIGEV_NONE;
>   	aiocbp.aio_sigevent.sigev_signo = 0;
> -#ifdef sgi
> -	aiocbp.aio_sigevent.sigev_func = NULL;
> -	aiocbp.aio_sigevent.sigev_value.sival_int = 0;
> -#elif defined(__linux__) && !defined(__UCLIBC__)
>   	aiocbp.aio_sigevent.sigev_notify_function = NULL;
>   	aiocbp.aio_sigevent.sigev_notify_attributes = 0;
> -#endif
> +
>   	aiolist[0] = &aiocbp;
>   
>   	if ((ret = lseek(fd, 0, SEEK_CUR)) == -1) {
> @@ -646,13 +586,10 @@ int lio_write_buffer(int fd,		/* open file descriptor */
>   			return -errno;
>   		}
>   	}
> -#if defined(sgi) || (defined(__linux__) && !defined(__UCLIBC__))
> +
>   	poffset = (off64_t) ret;
> -#endif
>   	aiocbp.aio_offset = ret;
>   
> -#endif
> -
>   	/*
>   	 * If the LIO_USE_SIGNAL bit is not set, only use the signal
>   	 * if the LIO_WAIT_SIGPAUSE or the LIO_WAIT_SIGACTIVE bits are bit.
> @@ -663,10 +600,8 @@ int lio_write_buffer(int fd,		/* open file descriptor */
>   
>   		sig = 0;	/* ignore signal parameter */
>   	}
> -#if defined(sgi) || (defined(__linux__) && !defined(__UCLIBC__))
>   	if (sig && (method & LIO_WAIT_CBTYPES))
>   		sig = 0;	/* ignore signal parameter */
> -#endif
>   
>   	/*
>   	 * only setup signal hander if sig was specified and
> @@ -677,26 +612,10 @@ int lio_write_buffer(int fd,		/* open file descriptor */
>   	 */
>   
>   	if (sig && (method & LIO_WAIT_SIGTYPES)) {
> -#ifdef CRAY
> -		sigctl(SCTL_REG, sig, lio_async_signal_handler);
> -#endif
> -#if defined(sgi) || (defined(__linux__) && !defined(__UCLIBC__))
>   		aiocbp.aio_sigevent.sigev_notify = SIGEV_SIGNAL;
>   		aiocbp.aio_sigevent.sigev_signo = sig;
>   		sigset(sig, lio_async_signal_handler);
> -#endif /* sgi */
> -	}
> -#if defined(sgi)
> -	else if (method & LIO_WAIT_CBTYPES) {
> -		/* sival_int just has to be something that I can use
> -		 * to identify the callback, and "size" happens to be handy...
> -		 */
> -		aiocbp.aio_sigevent.sigev_notify = SIGEV_CALLBACK;
> -		aiocbp.aio_sigevent.sigev_func = lio_async_callback_handler;
> -		aiocbp.aio_sigevent.sigev_value.sival_int = size;
>   	}
> -#endif
> -#if defined(__linux__) && !defined(__UCLIBC__)
>   	else if (method & LIO_WAIT_CBTYPES) {
>   		/* sival_int just has to be something that I can use
>   		 * to identify the callback, and "size" happens to be handy...
> @@ -707,7 +626,7 @@ int lio_write_buffer(int fd,		/* open file descriptor */
>   		aiocbp.aio_sigevent.sigev_notify_attributes =
>   		    (void *)(uintptr_t) size;
>   	}
> -#endif
> +
>   	/*
>   	 * Determine the system call that will be called and produce
>   	 * the string of the system call and place it in Lio_SysCall.
> @@ -765,27 +684,6 @@ int lio_write_buffer(int fd,		/* open file descriptor */
>   	}
>   
>   	else if (method & LIO_IO_ASYNC) {
> -#ifdef CRAY
> -		sprintf(Lio_SysCall,
> -			"writea(%d, buf, %d, &status, %d)", fd, size, sig);
> -		io_type = "writea";
> -
> -		if (Debug_level) {
> -			printf("DEBUG %s/%d: %s\n", __FILE__, __LINE__,
> -			       Lio_SysCall);
> -		}
> -
> -		sigoff();
> -		if ((ret = writea(fd, buffer, size, &status, sig)) == -1) {
> -			sprintf(Errormsg,
> -				"%s/%d writea(%d, buf, %d, &stat, %d) ret:-1, errno=%d %s",
> -				__FILE__, __LINE__,
> -				fd, size, sig, errno, strerror(errno));
> -			sigon();
> -			return -errno;
> -		}
> -#endif
> -#if defined(sgi) || (defined(__linux__) && !defined(__UCLIBC__))
>   		sprintf(Lio_SysCall,
>   			"aio_write(fildes=%d, buf, nbytes=%d, signo=%d)", fd,
>   			size, sig);
> @@ -807,53 +705,9 @@ int lio_write_buffer(int fd,		/* open file descriptor */
>   				sigrelse(sig);
>   			return -errno;
>   		}
> -#endif
>   	}
>   	/* LIO_IO_ASYNC */
>   	else if (method & LIO_IO_SLISTIO) {
> -#ifdef CRAY
> -		request.li_opcode = LO_WRITE;
> -		request.li_fildes = fd;
> -		request.li_buf = buffer;
> -		request.li_nbyte = size;
> -		request.li_status = &status;
> -		request.li_signo = sig;
> -		request.li_nstride = 0;
> -		request.li_filstride = 0;
> -		request.li_memstride = 0;
> -
> -		listio_cmd = LC_WAIT;
> -		io_type = "listio(2) sync write";
> -
> -		sprintf(Lio_SysCall,
> -			"listio(LC_WAIT, &req, 1) LO_WRITE, fd:%d, nbyte:%d",
> -			fd, size);
> -
> -		if (Debug_level) {
> -			printf("DEBUG %s/%d: %s\n", __FILE__, __LINE__,
> -			       Lio_SysCall);
> -		}
> -
> -		sigoff();
> -		if (listio(listio_cmd, &request, 1) == -1) {
> -			sprintf(Errormsg,
> -				"%s/%d %s failed, fd:%d, nbyte:%d errno=%d %s",
> -				__FILE__, __LINE__, Lio_SysCall, fd, size,
> -				errno, strerror(errno));
> -			sigon();
> -			return -errno;
> -		}
> -
> -		if (Debug_level > 1)
> -			printf("DEBUG %s/%d: %s did not return -1\n",
> -			       __FILE__, __LINE__, Lio_SysCall);
> -
> -		ret = lio_check_asyncio(io_type, size, &status);
> -		return ret;
> -
> -#endif
> -#if defined(sgi) || (defined(__linux__) && !defined(__UCLIBC__))
> -
>   		aiocbp.aio_lio_opcode = LIO_WRITE;
>   		listio_cmd = LIO_WAIT;
>   		io_type = "lio_listio(3) sync write";
> @@ -885,44 +739,9 @@ int lio_write_buffer(int fd,		/* open file descriptor */
>   
>   		ret = lio_check_asyncio(io_type, size, &aiocbp, method);
>   		return ret;
> -#endif
>   	}
>   	/* LIO_IO_SLISTIO */
>   	else if (method & LIO_IO_ALISTIO) {
> -#ifdef CRAY
> -		request.li_opcode = LO_WRITE;
> -		request.li_fildes = fd;
> -		request.li_buf = buffer;
> -		request.li_nbyte = size;
> -		request.li_status = &status;
> -		request.li_signo = sig;
> -		request.li_nstride = 0;
> -		request.li_filstride = 0;
> -		request.li_memstride = 0;
> -
> -		listio_cmd = LC_START;
> -		io_type = "listio(2) async write";
> -
> -		sprintf(Lio_SysCall,
> -			"listio(LC_START, &req, 1) LO_WRITE, fd:%d, nbyte:%d",
> -			fd, size);
> -
> -		if (Debug_level) {
> -			printf("DEBUG %s/%d: %s\n", __FILE__, __LINE__,
> -			       Lio_SysCall);
> -		}
> -
> -		sigoff();
> -		if (listio(listio_cmd, &request, 1) == -1) {
> -			sprintf(Errormsg,
> -				"%s/%d %s failed, fd:%d, nbyte:%d errno=%d %s",
> -				__FILE__, __LINE__, Lio_SysCall, fd, size,
> -				errno, strerror(errno));
> -			sigon();
> -			return -errno;
> -		}
> -#endif
> -#if defined (sgi) || (defined(__linux__) && !defined(__UCLIBC__))
>   		aiocbp.aio_lio_opcode = LIO_WRITE;
>   		listio_cmd = LIO_NOWAIT;
>   		io_type = "lio_listio(3) async write";
> @@ -947,41 +766,8 @@ int lio_write_buffer(int fd,		/* open file descriptor */
>   				sigrelse(sig);
>   			return -errno;
>   		}
> -#endif
>   	}
>   	/* LIO_IO_ALISTIO */
> -#ifndef CRAY
> -	else if (method & LIO_IO_SYNCV) {
> -		io_type = "writev(2)";
> -
> -		sprintf(Lio_SysCall, "writev(%d, &iov, 1) nbyte:%d", fd, size);
> -
> -		if (Debug_level) {
> -			printf("DEBUG %s/%d: %s\n", __FILE__, __LINE__,
> -			       Lio_SysCall);
> -		}
> -		if ((ret = writev(fd, &iov, 1)) == -1) {
> -			sprintf(Errormsg,
> -				"%s/%d writev(%d, iov, 1) nbyte:%d ret:-1, errno=%d %s",
> -				__FILE__, __LINE__, fd, size, errno,
> -				strerror(errno));
> -			return -errno;
> -		}
> -
> -		if (ret != size) {
> -			sprintf(Errormsg,
> -				"%s/%d writev(%d, iov, 1) nbyte:%d returned=%d",
> -				__FILE__, __LINE__, fd, size, ret);
> -		} else if (Debug_level > 1)
> -			printf
> -			    ("DEBUG %s/%d: writev completed without error (ret %d)\n",
> -			     __FILE__, __LINE__, ret);
> -
> -		return ret;
> -	}			/* LIO_IO_SYNCV */
> -#endif
> -
> -#if defined(sgi) || (defined(__linux__) && !defined(__UCLIBC__))
>   	else if (method & LIO_IO_SYNCP) {
>   		io_type = "pwrite(2)";
>   
> @@ -1013,8 +799,6 @@ int lio_write_buffer(int fd,		/* open file descriptor */
>   
>   		return ret;
>   	}			/* LIO_IO_SYNCP */
> -#endif
> -
>   	else {
>   		printf("DEBUG %s/%d: No I/O method chosen\n", __FILE__,
>   		       __LINE__);
> @@ -1024,12 +808,7 @@ int lio_write_buffer(int fd,		/* open file descriptor */
>   	/*
>   	 * wait for async io to complete.
>   	 */
> -#ifdef CRAY
> -	ret = lio_wait4asyncio(method, fd, statptr);
> -#endif
> -#if defined(sgi) || (defined(__linux__) && !defined(__UCLIBC__))
>   	ret = lio_wait4asyncio(method, fd, &aiocbp);
> -#endif
>   
>   	/*
>   	 * If there was an error waiting for async i/o to complete,
> @@ -1055,12 +834,7 @@ int lio_write_buffer(int fd,		/* open file descriptor */
>   	 * have been updated but the actual i/o size if returned.
>   	 */
>   
> -#ifdef CRAY
> -	ret = lio_check_asyncio(io_type, size, &status);
> -#endif
> -#if defined(sgi) || (defined(__linux__) && !defined(__UCLIBC__))
>   	ret = lio_check_asyncio(io_type, size, &aiocbp, method);
> -#endif
>   
>   	return ret;
>   }				/* end of lio_write_buffer */
> @@ -1121,23 +895,10 @@ int lio_read_buffer(int fd,	/* open file descriptor */
>   	char *io_type;		/* Holds string of type of io */
>   	int listio_cmd;		/* Holds the listio/lio_listio cmd */
>   	int omethod = method;
> -#ifdef  CRAY
> -	struct listreq request;	/* Used when a listio is wanted */
> -	struct iosw status, *statptr[1];
> -#else
> -	/* for linux or sgi */
>   	struct iovec iov;	/* iovec for readv(2) */
> -#endif
> -#ifdef sgi
> -	aiocb_t aiocbp;		/* POSIX aio control block */
> -	aiocb_t *aiolist[1];	/* list of aio control blocks for lio_listio */
> -	off64_t poffset;	/* pread(2) offset */
> -#endif
> -#if defined (__linux__) && !defined(__UCLIBC__)
>   	struct aiocb aiocbp;	/* POSIX aio control block */
>   	struct aiocb *aiolist[1];	/* list of aio control blocks for lio_listio */
>   	off64_t poffset;	/* pread(2) offset */
> -#endif
>   
>   	/*
>   	 * If LIO_RANDOM bit specified, get new method randomly.
> @@ -1156,39 +917,24 @@ int lio_read_buffer(int fd,	/* open file descriptor */
>   		*errmsg = Errormsg;
>   
>   	Rec_signal = Received_signal;	/* get the current number of signals received */
> -#if defined(sgi) || (defined(__linux__) && !defined(__UCLIBC__))
>   	Rec_callback = Received_callback;	/* get the current number of callbacks received */
> -#endif
>   
> -#ifdef  CRAY
> -	memset(&status, 0x00, sizeof(struct iosw));
> -	memset(&request, 0x00, sizeof(struct listreq));
> -	statptr[0] = &status;
> -#else
> -	/* for linux or sgi */
>   	memset(&iov, 0x00, sizeof(struct iovec));
>   	iov.iov_base = buffer;
>   	iov.iov_len = size;
> -#endif
> -#if defined(sgi) || (defined(__linux__) && !defined(__UCLIBC__))
> -#if defined(sgi)
> -	memset(&aiocbp, 0x00, sizeof(aiocb_t));
> -#else
> +
>   	memset(&aiocbp, 0x00, sizeof(struct aiocb));
> -#endif
> +
>   	aiocbp.aio_fildes = fd;
>   	aiocbp.aio_nbytes = size;
>   	aiocbp.aio_buf = buffer;
>   /*    aiocbp.aio_offset = lseek( fd, 0, SEEK_CUR ); -- set below */
>   	aiocbp.aio_sigevent.sigev_notify = SIGEV_NONE;
>   	aiocbp.aio_sigevent.sigev_signo = 0;
> -#ifdef sgi
> -	aiocbp.aio_sigevent.sigev_func = NULL;
> -	aiocbp.aio_sigevent.sigev_value.sival_int = 0;
> -#elif defined(__linux__) && !defined(__UCLIBC__)
> +
>   	aiocbp.aio_sigevent.sigev_notify_function = NULL;
>   	aiocbp.aio_sigevent.sigev_notify_attributes = 0;
> -#endif
> +
>   	aiolist[0] = &aiocbp;
>   
>   	if ((ret = lseek(fd, 0, SEEK_CUR)) == -1) {
> @@ -1222,13 +968,9 @@ int lio_read_buffer(int fd,	/* open file descriptor */
>   			return -errno;
>   		}
>   	}
> -#if defined(sgi) || (defined(__linux__) && !defined(__UCLIBC__))
>   	poffset = (off64_t) ret;
> -#endif
>   	aiocbp.aio_offset = ret;
>   
> -#endif
> -
>   	/*
>   	 * If the LIO_USE_SIGNAL bit is not set, only use the signal
>   	 * if the LIO_WAIT_SIGPAUSE or the LIO_WAIT_SIGACTIVE bits are set.
> @@ -1239,10 +981,9 @@ int lio_read_buffer(int fd,	/* open file descriptor */
>   
>   		sig = 0;	/* ignore signal parameter */
>   	}
> -#if defined(sgi) || (defined(__linux__)&& !defined(__UCLIBC__))
> +
>   	if (sig && (method & LIO_WAIT_CBTYPES))
>   		sig = 0;	/* ignore signal parameter */
> -#endif
>   
>   	/*
>   	 * only setup signal hander if sig was specified and
> @@ -1253,27 +994,10 @@ int lio_read_buffer(int fd,	/* open file descriptor */
>   	 */
>   
>   	if (sig && (method & LIO_WAIT_SIGTYPES)) {
> -#ifdef CRAY
> -		sigctl(SCTL_REG, sig, lio_async_signal_handler);
> -#endif
> -#if defined(sgi) || (defined(__linux__) && !defined(__UCLIBC__))
>   		aiocbp.aio_sigevent.sigev_notify = SIGEV_SIGNAL;
>   		aiocbp.aio_sigevent.sigev_signo = sig;
>   		sigset(sig, lio_async_signal_handler);
> -#endif /* CRAY */
> -	}
> -#if defined(sgi)
> -	else if (method & LIO_WAIT_CBTYPES) {
> -		aiocbp.aio_sigevent.sigev_notify = SIGEV_CALLBACK;
> -		aiocbp.aio_sigevent.sigev_func = lio_async_callback_handler;
> -		/* sival_int just has to be something that I can use
> -		 * to identify the callback, and "size" happens to be handy...
> -		 */
> -		aiocbp.aio_sigevent.sigev_value.sival_int = size;
> -	}
> -#endif
> -#if defined(__linux__) && !defined(__UCLIBC__)
> -	else if (method & LIO_WAIT_CBTYPES) {
> +	} else if (method & LIO_WAIT_CBTYPES) {
>   		aiocbp.aio_sigevent.sigev_notify = SIGEV_THREAD;
>   		aiocbp.aio_sigevent.sigev_notify_function =
>   		    lio_async_callback_handler;
> @@ -1283,7 +1007,6 @@ int lio_read_buffer(int fd,	/* open file descriptor */
>   		aiocbp.aio_sigevent.sigev_notify_attributes =
>   		    (void *)(uintptr_t) size;
>   	}
> -#endif
>   
>   	/*
>   	 * Determine the system call that will be called and produce
> @@ -1342,30 +1065,7 @@ int lio_read_buffer(int fd,	/* open file descriptor */
>   			wait4sync_io(fd, 1);
>   		}
>   
> -	}
> -
> -	else if (method & LIO_IO_ASYNC) {
> -#ifdef CRAY
> -		sprintf(Lio_SysCall,
> -			"reada(%d, buf, %d, &status, %d)", fd, size, sig);
> -		io_type = "reada";
> -
> -		if (Debug_level) {
> -			printf("DEBUG %s/%d: %s\n", __FILE__, __LINE__,
> -			       Lio_SysCall);
> -		}
> -
> -		sigoff();
> -		if ((ret = reada(fd, buffer, size, &status, sig)) == -1) {
> -			sprintf(Errormsg,
> -				"%s/%d reada(%d, buf, %d, &stat, %d) ret:-1, errno=%d %s",
> -				__FILE__, __LINE__,
> -				fd, size, sig, errno, strerror(errno));
> -			sigon();
> -			return -errno;
> -		}
> -#endif
> -#if defined(sgi) || (defined(__linux__) && !defined(__UCLIBC__))
> +	} else if (method & LIO_IO_ASYNC) {
>   		sprintf(Lio_SysCall,
>   			"aio_read(fildes=%d, buf, nbytes=%d, signo=%d)", fd,
>   			size, sig);
> @@ -1387,51 +1087,9 @@ int lio_read_buffer(int fd,	/* open file descriptor */
>   				sigrelse(sig);
>   			return -errno;
>   		}
> -#endif
>   	}
>   	/* LIO_IO_ASYNC */
>   	else if (method & LIO_IO_SLISTIO) {
> -#ifdef CRAY
> -		request.li_opcode = LO_READ;
> -		request.li_fildes = fd;
> -		request.li_buf = buffer;
> -		request.li_nbyte = size;
> -		request.li_status = &status;
> -		request.li_signo = sig;
> -		request.li_nstride = 0;
> -		request.li_filstride = 0;
> -		request.li_memstride = 0;
> -
> -		listio_cmd = LC_WAIT;
> -		io_type = "listio(2) sync read";
> -
> -		sprintf(Lio_SysCall,
> -			"listio(LC_WAIT, &req, 1) LO_READ, fd:%d, nbyte:%d",
> -			fd, size);
> -
> -		if (Debug_level) {
> -			printf("DEBUG %s/%d: %s\n", __FILE__, __LINE__,
> -			       Lio_SysCall);
> -		}
> -
> -		sigoff();
> -		if (listio(listio_cmd, &request, 1) == -1) {
> -			sprintf(Errormsg,
> -				"%s/%d %s failed, fd:%d, nbyte:%d errno=%d %s",
> -				__FILE__, __LINE__, Lio_SysCall, fd, size,
> -				errno, strerror(errno));
> -			sigon();
> -			return -errno;
> -		}
> -
> -		if (Debug_level > 1)
> -			printf("DEBUG %s/%d: %s did not return -1\n",
> -			       __FILE__, __LINE__, Lio_SysCall);
> -
> -		ret = lio_check_asyncio(io_type, size, &status);
> -		return ret;
> -#endif
> -#if defined(sgi) || (defined(__linux__) && !defined(__UCLIBC__))
>   		aiocbp.aio_lio_opcode = LIO_READ;
>   		listio_cmd = LIO_WAIT;
>   		io_type = "lio_listio(3) sync read";
> @@ -1463,44 +1121,9 @@ int lio_read_buffer(int fd,	/* open file descriptor */
>   
>   		ret = lio_check_asyncio(io_type, size, &aiocbp, method);
>   		return ret;
> -#endif
>   	}
>   	/* LIO_IO_SLISTIO */
>   	else if (method & LIO_IO_ALISTIO) {
> -#ifdef CRAY
> -		request.li_opcode = LO_READ;
> -		request.li_fildes = fd;
> -		request.li_buf = buffer;
> -		request.li_nbyte = size;
> -		request.li_status = &status;
> -		request.li_signo = sig;
> -		request.li_nstride = 0;
> -		request.li_filstride = 0;
> -		request.li_memstride = 0;
> -
> -		listio_cmd = LC_START;
> -		io_type = "listio(2) async read";
> -
> -		sprintf(Lio_SysCall,
> -			"listio(LC_START, &req, 1) LO_READ, fd:%d, nbyte:%d",
> -			fd, size);
> -
> -		if (Debug_level) {
> -			printf("DEBUG %s/%d: %s\n", __FILE__, __LINE__,
> -			       Lio_SysCall);
> -		}
> -
> -		sigoff();
> -		if (listio(listio_cmd, &request, 1) == -1) {
> -			sprintf(Errormsg,
> -				"%s/%d %s failed, fd:%d, nbyte:%d errno=%d %s",
> -				__FILE__, __LINE__, Lio_SysCall, fd, size,
> -				errno, strerror(errno));
> -			sigon();
> -			return -errno;
> -		}
> -#endif
> -#if defined(sgi) || (defined(__linux__) && !defined(__UCLIBC__))
>   		aiocbp.aio_lio_opcode = LIO_READ;
>   		listio_cmd = LIO_NOWAIT;
>   		io_type = "lio_listio(3) async read";
> @@ -1525,41 +1148,8 @@ int lio_read_buffer(int fd,	/* open file descriptor */
>   				sigrelse(sig);
>   			return -errno;
>   		}
> -#endif
>   	}
>   	/* LIO_IO_ALISTIO */
> -#ifndef CRAY
> -	else if (method & LIO_IO_SYNCV) {
> -		io_type = "readv(2)";
> -
> -		sprintf(Lio_SysCall, "readv(%d, &iov, 1) nbyte:%d", fd, size);
> -
> -		if (Debug_level) {
> -			printf("DEBUG %s/%d: %s\n", __FILE__, __LINE__,
> -			       Lio_SysCall);
> -		}
> -		if ((ret = readv(fd, &iov, 1)) == -1) {
> -			sprintf(Errormsg,
> -				"%s/%d readv(%d, iov, 1) nbyte:%d ret:-1, errno=%d %s",
> -				__FILE__, __LINE__, fd, size, errno,
> -				strerror(errno));
> -			return -errno;
> -		}
> -
> -		if (ret != size) {
> -			sprintf(Errormsg,
> -				"%s/%d readv(%d, iov, 1) nbyte:%d returned=%d",
> -				__FILE__, __LINE__, fd, size, ret);
> -		} else if (Debug_level > 1)
> -			printf
> -			    ("DEBUG %s/%d: readv completed without error (ret %d)\n",
> -			     __FILE__, __LINE__, ret);
> -
> -		return ret;
> -	}			/* LIO_IO_SYNCV */
> -#endif
> -
> -#if defined(sgi) || (defined(__linux__) && !defined(__UCLIBC__))
>   	else if (method & LIO_IO_SYNCP) {
>   		io_type = "pread(2)";
>   
> @@ -1591,7 +1181,6 @@ int lio_read_buffer(int fd,	/* open file descriptor */
>   
>   		return ret;
>   	}			/* LIO_IO_SYNCP */
> -#endif
>   
>   	else {
>   		printf("DEBUG %s/%d: No I/O method chosen\n", __FILE__,
> @@ -1603,12 +1192,7 @@ int lio_read_buffer(int fd,	/* open file descriptor */
>   	 * wait for async io to complete.
>   	 * Note: Sync io should have returned prior to getting here.
>   	 */
> -#ifdef CRAY
> -	ret = lio_wait4asyncio(method, fd, statptr);
> -#endif
> -#if defined(sgi) || (defined(__linux__) && !defined(__UCLIBC__))
>   	ret = lio_wait4asyncio(method, fd, &aiocbp);
> -#endif
>   
>   	/*
>   	 * If there was an error waiting for async i/o to complete,
> @@ -1634,12 +1218,7 @@ int lio_read_buffer(int fd,	/* open file descriptor */
>   	 * have been updated but the actual i/o size if returned.
>   	 */
>   
> -#ifdef CRAY
> -	ret = lio_check_asyncio(io_type, size, &status);
> -#endif
> -#if defined(sgi) || (defined(__linux__) && !defined(__UCLIBC__))
>   	ret = lio_check_asyncio(io_type, size, &aiocbp, method);
> -#endif
>   
>   	return ret;
>   }				/* end of lio_read_buffer */
> @@ -1656,37 +1235,9 @@ int lio_read_buffer(int fd,	/* open file descriptor */
>    *
>    * (rrl 04/96)
>    ***********************************************************************/
> -#ifdef CRAY
> -int lio_check_asyncio(char *io_type, int size, struct iosw *status)
> -#elif defined(sgi)
> -int lio_check_asyncio(char *io_type, int size, aiocb_t * aiocbp, int method)
> -#elif defined(__linux__) && !defined(__UCLIBC__)
>   int lio_check_asyncio(char *io_type, int size, struct aiocb *aiocbp, int method)
>   {
>   	int ret;
> -
> -#ifdef CRAY
> -	if (status->sw_error) {
> -		sprintf(Errormsg,
> -			"%s/%d %s, sw_error set = %d %s, sw_count = %d",
> -			__FILE__, __LINE__, io_type,
> -			status->sw_error, strerror(status->sw_error),
> -			status->sw_count);
> -		return -status->sw_error;
> -	} else if (status->sw_count != size) {
> -		sprintf(Errormsg,
> -			"%s/%d %s, sw_count not as expected(%d), but actual:%d",
> -			__FILE__, __LINE__, io_type, size, status->sw_count);
> -	} else if (Debug_level > 1) {
> -		printf
> -		    ("DEBUG %s/%d: %s completed without error (sw_error == 0, sw_count == %d)\n",
> -		     __FILE__, __LINE__, io_type, status->sw_count);
> -	}
> -
> -	return status->sw_count;
> -
> -#else
> -
>   	int cnt = 1;
>   
>   	/* The I/O may have been synchronous with signal completion.  It doesn't
> @@ -1710,10 +1261,6 @@ int lio_check_asyncio(char *io_type, int size, struct aiocb *aiocbp, int method)
>   			(aiocbp->aio_sigevent.sigev_notify ==
>   			 SIGEV_SIGNAL ? "signal" : aiocbp->aio_sigevent.
>   			 sigev_notify == SIGEV_NONE ? "none" :
> -#ifdef SIGEV_CALLBACK
> -			 aiocbp->aio_sigevent.sigev_notify ==
> -			 SIGEV_CALLBACK ? "callback" :
> -#endif
>   			 aiocbp->aio_sigevent.sigev_notify ==
>   			 SIGEV_THREAD ? "thread" : "unknown"));
>   		return -ret;
> @@ -1731,18 +1278,6 @@ int lio_check_asyncio(char *io_type, int size, struct aiocb *aiocbp, int method)
>   		sprintf(Errormsg,
>   			"%s/%d %s, aio_return not as expected(%d), but actual:%d",
>   			__FILE__, __LINE__, io_type, size, ret);
> -
> -#ifdef BUG1_workaround
> -		if (ret == 0) {
> -			ret = size;
> -			if (Debug_level > 1) {
> -				printf
> -				    ("WARN %s/%d: %s completed with bug1_workaround (aio_error == 0, aio_return now == %d)\n",
> -				     __FILE__, __LINE__, io_type, ret);
> -			}
> -		}
> -#endif /* BUG1_workaround */
> -
>   	} else if (Debug_level > 1) {
>   		printf
>   		    ("DEBUG %s/%d: %s completed without error (aio_error == 0, aio_return == %d)\n",
> @@ -1751,9 +1286,7 @@ int lio_check_asyncio(char *io_type, int size, struct aiocb *aiocbp, int method)
>   
>   	return ret;
>   
> -#endif
>   }				/* end of lio_check_asyncio */
> -#endif
>   
>   /***********************************************************************
>    *
> @@ -1773,45 +1306,20 @@ int lio_check_asyncio(char *io_type, int size, struct aiocb *aiocbp, int method)
>    *
>    * (rrl 04/96)
>    ***********************************************************************/
> -#ifdef CRAY
> -int lio_wait4asyncio(int method, int fd, struct iosw **statptr)
> -#elif defined(sgi)
> -int lio_wait4asyncio(int method, int fd, aiocb_t * aiocbp)
> -#elif defined(__linux__) && !defined(__UCLIBC__)
>   int lio_wait4asyncio(int method, int fd, struct aiocb *aiocbp)
>   {
>   	int cnt;
> -#ifdef sgi
> -	int ret;
> -	const aiocb_t *aioary[1];
> -#endif
> -#if defined(__linux__)&& !defined(__UCLIBC__)
>   	int ret;
>   	const struct aiocb *aioary[1];
> -#endif
>   
>   	if ((method & LIO_WAIT_RECALL)
> -#if defined(sgi) || (defined(__linux__)&& !defined(__UCLIBC__))
>   	    || (method & LIO_WAIT_CBSUSPEND)
>   	    || (method & LIO_WAIT_SIGSUSPEND)
> -#endif
>   	    || ((method & LIO_WAIT_TYPES) == 0)) {
>   		/*
>   		 * If method has LIO_WAIT_RECALL bit set or method does
>   		 * not have any wait method bits set (default), use recall/aio_suspend.
>   		 */
> -#ifdef CRAY
> -		if (Debug_level > 2)
> -			printf("DEBUG %s/%d: wait method : recall\n", __FILE__,
> -			       __LINE__);
> -		sigon();
> -		if (recall(fd, 1, statptr)) {
> -			sprintf(Errormsg,
> -				"%s/%d recall(%d, 1, stat) failed, errno:%d %s",
> -				__FILE__, __LINE__, fd, errno, strerror(errno));
> -			return -errno;
> -		}
> -#else
>   		if (Debug_level > 2)
>   			printf
>   			    ("DEBUG %s/%d: wait method : aio_suspend, sigev_notify=%s\n",
> @@ -1819,10 +1327,6 @@ int lio_wait4asyncio(int method, int fd, struct aiocb *aiocbp)
>   			     (aiocbp->aio_sigevent.sigev_notify ==
>   			      SIGEV_SIGNAL ? "signal" : aiocbp->aio_sigevent.
>   			      sigev_notify == SIGEV_NONE ? "none" :
> -#ifdef SIGEV_CALLBACK
> -			      aiocbp->aio_sigevent.sigev_notify ==
> -			      SIGEV_CALLBACK ? "callback" :
> -#endif
>   			      aiocbp->aio_sigevent.sigev_notify ==
>   			      SIGEV_THREAD ? "thread" : "unknown"));
>   
> @@ -1843,10 +1347,6 @@ int lio_wait4asyncio(int method, int fd, struct aiocb *aiocbp)
>   					 SIGEV_SIGNAL ? "signal" : aiocbp->
>   					 aio_sigevent.sigev_notify ==
>   					 SIGEV_NONE ? "none" :
> -#ifdef SIGEV_CALLBACK
> -					 aiocbp->aio_sigevent.sigev_notify ==
> -					 SIGEV_CALLBACK ? "callback" :
> -#endif
>   					 aiocbp->aio_sigevent.sigev_notify ==
>   					 SIGEV_THREAD ? "thread" : "unknown"));
>   				return -errno;
> @@ -1857,24 +1357,10 @@ int lio_wait4asyncio(int method, int fd, struct aiocb *aiocbp)
>   				__FILE__, __LINE__, fd, errno, strerror(errno));
>   			return -errno;
>   		}
> -#endif
> -
>   	} else if (method & LIO_WAIT_ACTIVE) {
>   		if (Debug_level > 2)
>   			printf("DEBUG %s/%d: wait method : active\n", __FILE__,
>   			       __LINE__);
> -#ifdef CRAY
> -		sigon();
> -		/*
> -		 * loop until sw_flag, sw_count or sw_error field elements
> -		 * change to non-zero.
> -		 */
> -		cnt = 0;
> -		while ((*statptr)->sw_flag == 0 &&
> -		       (*statptr)->sw_count == 0 && (*statptr)->sw_error == 0) {
> -			cnt++;
> -		}
> -#else
>   		/* loop while aio_error() returns EINPROGRESS */
>   		cnt = 0;
>   		while (1) {
> @@ -1885,7 +1371,6 @@ int lio_wait4asyncio(int method, int fd, struct aiocb *aiocbp)
>   			++cnt;
>   		}
>   
> -#endif
>   		if (Debug_level > 5 && cnt && (cnt % 50) == 0)
>   			printf("DEBUG %s/%d: wait active cnt = %d\n",
>   			       __FILE__, __LINE__, cnt);
> @@ -1894,25 +1379,12 @@ int lio_wait4asyncio(int method, int fd, struct aiocb *aiocbp)
>   		if (Debug_level > 2)
>   			printf("DEBUG %s/%d: wait method : sigpause\n",
>   			       __FILE__, __LINE__);
> -#ifdef sgi
> -		/* note: don't do the sigon() for CRAY in this case.  why? -- roehrich 6/11/97 */
> -		if (aiocbp->aio_sigevent.sigev_notify == SIGEV_SIGNAL)
> -			sigrelse(aiocbp->aio_sigevent.sigev_signo);
> -		else {
> -			printf("DEBUG %s/%d: sigev_notify != SIGEV_SIGNAL\n",
> -			       __FILE__, __LINE__);
> -			return -1;
> -		}
> -#endif
>   		pause();
>   
>   	} else if (method & LIO_WAIT_SIGACTIVE) {
>   		if (Debug_level > 2)
>   			printf("DEBUG %s/%d: wait method : sigactive\n",
>   			       __FILE__, __LINE__);
> -#ifdef CRAY
> -		sigon();
> -#else
>   		if (aiocbp->aio_sigevent.sigev_notify == SIGEV_SIGNAL)
>   			sigrelse(aiocbp->aio_sigevent.sigev_signo);
>   		else {
> @@ -1920,14 +1392,9 @@ int lio_wait4asyncio(int method, int fd, struct aiocb *aiocbp)
>   			       __FILE__, __LINE__);
>   			return -1;
>   		}
> -#endif
>   		/* loop waiting for signal */
>   		while (Received_signal == Rec_signal) {
> -#ifdef CRAY
> -			sigon();
> -#else
>   			sigrelse(aiocbp->aio_sigevent.sigev_signo);
> -#endif
>   		}
>   
>   	} else if (method & LIO_WAIT_NONE) {
> @@ -1944,10 +1411,6 @@ int lio_wait4asyncio(int method, int fd, struct aiocb *aiocbp)
>   		sprintf(Errormsg,
>   			"%s/%d LIO_WAIT_NONE was selected (this is broken)\n",
>   			__FILE__, __LINE__);
> -#ifdef CRAY
> -		sigon();
> -#endif
> -/*        return 1;*/
>   		return -1;
>   	} else {
>   		if (Debug_level > 2)
> @@ -1960,7 +1423,6 @@ int lio_wait4asyncio(int method, int fd, struct aiocb *aiocbp)
>   
>   }				/* end of lio_wait4asyncio */
>   
> -#endif /* ifndef linux */
>   #endif
>   
>   #if UNIT_TEST

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
