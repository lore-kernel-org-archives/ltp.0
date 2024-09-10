Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A85C1EB64DE
	for <ltp@archiver.kernel.org>; Tue, 10 Sep 2024 13:38:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 075083C1B14
	for <ltp@archiver.kernel.org>; Tue, 10 Sep 2024 15:38:07 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4561E3C1ABA
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 15:37:51 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 224B21001198
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 15:37:50 +0200 (CEST)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-374c4d4f219so457764f8f.1
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 06:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725975469; x=1726580269; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YUAIO1FnoRnlWsjWCbOgSlRKjX5GupFyFtflTy016is=;
 b=Fl27no8p+16qNL9ScD7+tng/1m9IK2YBADpzNMIGLgBkkGRR+TtIni4ATyUGdPG7/G
 Dl/5b7EjfCSuQKpPxB8xwYfRdPhg5jj50UdbxVq3PduSlINzG7pS41xDZOYkKyQm2j3a
 aYGu9KYpAQH4qYmgtOnIr9uApabZ6WtvWikr37zxECg+YmXLYRHKtxR7IiTCG8L08GIj
 n5UZDgxERUhnxHq2FjcolYP1kst6e9mbOpZE2uHDs0toyGBKp4Ag3CjCSUZ+6CgOgHFm
 MS8/R0r2u0XrLocOrFezGqF7uzjWVTukD7ls0iuRz7sdIStWU1H+yX/zXrmED+jFsyaX
 lDUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725975469; x=1726580269;
 h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YUAIO1FnoRnlWsjWCbOgSlRKjX5GupFyFtflTy016is=;
 b=JPcG0jKOjAAuaIWYeHYoedxZIqies0NdBwn45FiSejrvXWJIfTLFNw91k1opqyH5Wy
 /5+ooXIcSKa+M4Kw+1SAkoMQKItFLRzWaAgaqlaVF0pUFz1362MSU95fqNhqsWyCIb6g
 a4cQg7v917FDVyODgC/Z4TDNbmIYa+shiwN+bdsT5HP6tH9OJc63z6rcy/Q+hgbUh/O8
 L38HwLIufUKKocTh+UwuM1fTGOtkJah1Rf0AvBryBRtE++bBKQd8Z3tU7tUrvRn21Fn2
 DJOCmtCRjGJ0HWdavh1tjUHMQ1+0y7TtgY1nwkIDIobHdaIqdZxS+RQ5V2cm4hB+6+o1
 Vrrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXA60r1ui6tcak9kzJbBYAKiV1rzV0aWtm/gsxepWcn+1MxdihcJB9YST/hBPcJenqoDuo=@lists.linux.it
X-Gm-Message-State: AOJu0Yy8aG2+KQzXZMR3uptmsAGD7Z4WDDZcD+CQExPwcbIQ+t2/RT8r
 6YFdPS9uqp7UyxUlcmYBvI3sKw5waUCkFc8G7AymjltAhmAQzmOagdrf3MUYKs8=
X-Google-Smtp-Source: AGHT+IFZAurGcP7RS6kRlVX+Yh54BI3rcFSZZWKcCEf3Ou7t9Byx38yLJvJtBuSMd3ajD1wKab+Z9Q==
X-Received: by 2002:a05:6000:a84:b0:35f:122e:bd8c with SMTP id
 ffacd0b85a97d-378895ca7fbmr9340223f8f.17.1725975469141; 
 Tue, 10 Sep 2024 06:37:49 -0700 (PDT)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3789564a242sm8943756f8f.22.2024.09.10.06.37.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 06:37:48 -0700 (PDT)
Date: Tue, 10 Sep 2024 16:37:44 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Xiao Yang <ice_yangxiao@163.com>,
 Liam.Howlett@oracle.com, linux-mm@kvack.org
Message-ID: <d30bf8ee-6edc-4bea-adba-8d54ba520b6c@stanley.mountain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240909050226.2053-1-ice_yangxiao@163.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mm/vma: Return the exact errno for __split_vma()
 and mas_store_gfp()
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
Cc: lkp@intel.com, linux-kernel@vger.kernel.org, oliver.sang@intel.com,
 oe-kbuild-all@lists.linux.dev, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xiao,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Xiao-Yang/mm-vma-Return-the-exact-errno-for-__split_vma-and-mas_store_gfp/20240909-130325
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240909050226.2053-1-ice_yangxiao%40163.com
patch subject: [PATCH] mm/vma: Return the exact errno for __split_vma() and mas_store_gfp()
config: x86_64-randconfig-161-20240910 (https://download.01.org/0day-ci/archive/20240910/202409102026.LOh8J1Lh-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202409102026.LOh8J1Lh-lkp@intel.com/

smatch warnings:
mm/vma.c:1263 vms_gather_munmap_vmas() warn: missing error code 'error'

vim +/error +1263 mm/vma.c

49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1166  /*
dba14840905f9e Liam R. Howlett 2024-08-30  1167   * vms_gather_munmap_vmas() - Put all VMAs within a range into a maple tree
6898c9039bc8e3 Liam R. Howlett 2024-08-30  1168   * for removal at a later date.  Handles splitting first and last if necessary
6898c9039bc8e3 Liam R. Howlett 2024-08-30  1169   * and marking the vmas as isolated.
6898c9039bc8e3 Liam R. Howlett 2024-08-30  1170   *
dba14840905f9e Liam R. Howlett 2024-08-30  1171   * @vms: The vma munmap struct
6898c9039bc8e3 Liam R. Howlett 2024-08-30  1172   * @mas_detach: The maple state tracking the detached tree
49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1173   *
6898c9039bc8e3 Liam R. Howlett 2024-08-30  1174   * Return: 0 on success, -EPERM on mseal vmas, -ENOMEM otherwise

This comment needs to be updated.

49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1175   */
9014b230d88d7f Liam R. Howlett 2024-08-30  1176  int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
dba14840905f9e Liam R. Howlett 2024-08-30  1177  		struct ma_state *mas_detach)
49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1178  {
01cf21e9e11957 Liam R. Howlett 2024-08-30  1179  	struct vm_area_struct *next = NULL;
49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1180  	int error = -ENOMEM;
49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1181  
49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1182  	/*
49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1183  	 * If we need to split any vma, do it now to save pain later.
20831cd6f814ea Liam R. Howlett 2024-08-30  1184  	 * Does it split the first one?
49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1185  	 */
dba14840905f9e Liam R. Howlett 2024-08-30  1186  	if (vms->start > vms->vma->vm_start) {
49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1187  
49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1188  		/*
49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1189  		 * Make sure that map_count on return from munmap() will
49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1190  		 * not exceed its limit; but let map_count go just above
49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1191  		 * its limit temporarily, to help free resources as expected.
49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1192  		 */
dba14840905f9e Liam R. Howlett 2024-08-30  1193  		if (vms->end < vms->vma->vm_end &&
63fc66f5b6b18f Liam R. Howlett 2024-08-30  1194  		    vms->vma->vm_mm->map_count >= sysctl_max_map_count)
49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1195  			goto map_count_exceeded;
49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1196  
df2a7df9a9aa32 Pedro Falcato   2024-08-17  1197  		/* Don't bother splitting the VMA if we can't unmap it anyway */
dba14840905f9e Liam R. Howlett 2024-08-30  1198  		if (!can_modify_vma(vms->vma)) {
df2a7df9a9aa32 Pedro Falcato   2024-08-17  1199  			error = -EPERM;
df2a7df9a9aa32 Pedro Falcato   2024-08-17  1200  			goto start_split_failed;
df2a7df9a9aa32 Pedro Falcato   2024-08-17  1201  		}
df2a7df9a9aa32 Pedro Falcato   2024-08-17  1202  
013545e1b9bca0 Xiao Yang       2024-09-09  1203  		error = __split_vma(vms->vmi, vms->vma, vms->start, 1);
013545e1b9bca0 Xiao Yang       2024-09-09  1204  		if (error)
49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1205  			goto start_split_failed;
49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1206  	}
17f1ae9b40c6b0 Liam R. Howlett 2024-08-30  1207  	vms->prev = vma_prev(vms->vmi);
9c3ebeda8fb5a8 Liam R. Howlett 2024-08-30  1208  	if (vms->prev)
9c3ebeda8fb5a8 Liam R. Howlett 2024-08-30  1209  		vms->unmap_start = vms->prev->vm_end;
49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1210  
49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1211  	/*
49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1212  	 * Detach a range of VMAs from the mm. Using next as a temp variable as
49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1213  	 * it is always overwritten.
49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1214  	 */
17f1ae9b40c6b0 Liam R. Howlett 2024-08-30  1215  	for_each_vma_range(*(vms->vmi), next, vms->end) {
17f1ae9b40c6b0 Liam R. Howlett 2024-08-30  1216  		long nrpages;
17f1ae9b40c6b0 Liam R. Howlett 2024-08-30  1217  
df2a7df9a9aa32 Pedro Falcato   2024-08-17  1218  		if (!can_modify_vma(next)) {
df2a7df9a9aa32 Pedro Falcato   2024-08-17  1219  			error = -EPERM;
df2a7df9a9aa32 Pedro Falcato   2024-08-17  1220  			goto modify_vma_failed;
df2a7df9a9aa32 Pedro Falcato   2024-08-17  1221  		}
49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1222  		/* Does it split the end? */
dba14840905f9e Liam R. Howlett 2024-08-30  1223  		if (next->vm_end > vms->end) {
013545e1b9bca0 Xiao Yang       2024-09-09  1224  			error = __split_vma(vms->vmi, next, vms->end, 0);
013545e1b9bca0 Xiao Yang       2024-09-09  1225  			if (error)
49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1226  				goto end_split_failed;
49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1227  		}
49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1228  		vma_start_write(next);
dba14840905f9e Liam R. Howlett 2024-08-30  1229  		mas_set(mas_detach, vms->vma_count++);
013545e1b9bca0 Xiao Yang       2024-09-09  1230  		error = mas_store_gfp(mas_detach, next, GFP_KERNEL);
013545e1b9bca0 Xiao Yang       2024-09-09  1231  		if (error)
49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1232  			goto munmap_gather_failed;
6898c9039bc8e3 Liam R. Howlett 2024-08-30  1233  
49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1234  		vma_mark_detached(next, true);
17f1ae9b40c6b0 Liam R. Howlett 2024-08-30  1235  		nrpages = vma_pages(next);
17f1ae9b40c6b0 Liam R. Howlett 2024-08-30  1236  
17f1ae9b40c6b0 Liam R. Howlett 2024-08-30  1237  		vms->nr_pages += nrpages;
49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1238  		if (next->vm_flags & VM_LOCKED)
17f1ae9b40c6b0 Liam R. Howlett 2024-08-30  1239  			vms->locked_vm += nrpages;
17f1ae9b40c6b0 Liam R. Howlett 2024-08-30  1240  
17f1ae9b40c6b0 Liam R. Howlett 2024-08-30  1241  		if (next->vm_flags & VM_ACCOUNT)
17f1ae9b40c6b0 Liam R. Howlett 2024-08-30  1242  			vms->nr_accounted += nrpages;
17f1ae9b40c6b0 Liam R. Howlett 2024-08-30  1243  
17f1ae9b40c6b0 Liam R. Howlett 2024-08-30  1244  		if (is_exec_mapping(next->vm_flags))
17f1ae9b40c6b0 Liam R. Howlett 2024-08-30  1245  			vms->exec_vm += nrpages;
17f1ae9b40c6b0 Liam R. Howlett 2024-08-30  1246  		else if (is_stack_mapping(next->vm_flags))
17f1ae9b40c6b0 Liam R. Howlett 2024-08-30  1247  			vms->stack_vm += nrpages;
17f1ae9b40c6b0 Liam R. Howlett 2024-08-30  1248  		else if (is_data_mapping(next->vm_flags))
17f1ae9b40c6b0 Liam R. Howlett 2024-08-30  1249  			vms->data_vm += nrpages;
49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1250  
dba14840905f9e Liam R. Howlett 2024-08-30  1251  		if (unlikely(vms->uf)) {
49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1252  			/*
49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1253  			 * If userfaultfd_unmap_prep returns an error the vmas
49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1254  			 * will remain split, but userland will get a
49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1255  			 * highly unexpected error anyway. This is no
49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1256  			 * different than the case where the first of the two
49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1257  			 * __split_vma fails, but we don't undo the first
49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1258  			 * split, despite we could. This is unlikely enough
49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1259  			 * failure that it's not worth optimizing it for.
49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1260  			 */
dba14840905f9e Liam R. Howlett 2024-08-30  1261  			if (userfaultfd_unmap_prep(next, vms->start, vms->end,
dba14840905f9e Liam R. Howlett 2024-08-30  1262  						   vms->uf))
49b1b8d6f68310 Lorenzo Stoakes 2024-07-29 @1263  				goto userfaultfd_error;

Needs an "error = -ENOMEM;" here.  I haven't reviewed this function outside of
what the zero day bot puts into this email.

49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1264  		}
49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1265  #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
dba14840905f9e Liam R. Howlett 2024-08-30  1266  		BUG_ON(next->vm_start < vms->start);
dba14840905f9e Liam R. Howlett 2024-08-30  1267  		BUG_ON(next->vm_start > vms->end);
49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1268  #endif
17f1ae9b40c6b0 Liam R. Howlett 2024-08-30  1269  	}
17f1ae9b40c6b0 Liam R. Howlett 2024-08-30  1270  
17f1ae9b40c6b0 Liam R. Howlett 2024-08-30  1271  	vms->next = vma_next(vms->vmi);
9c3ebeda8fb5a8 Liam R. Howlett 2024-08-30  1272  	if (vms->next)
9c3ebeda8fb5a8 Liam R. Howlett 2024-08-30  1273  		vms->unmap_end = vms->next->vm_start;
49b1b8d6f68310 Lorenzo Stoakes 2024-07-29  1274  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
