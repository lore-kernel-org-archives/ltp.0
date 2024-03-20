Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7EACC54E67
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 07:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1710920720; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=rU4RWkzrVBpjdZFbAgxvUzudhq14+LrPUcxgeyPEv18=;
 b=l8stY/Ybubpov0m/fqpJORalHtBiweXjPFkTN8yyoX/Iuak3ZQNwCEtqzbql6Oo8bVyks
 B8vxtf7CjH8zvEjRhvCL6Mf8VWd+fSWUsJODFtqIQdshLQ1hi14/JIYQIbGQEUr7b54u8DV
 q/cb6Xvw7oB865D1KeKfWySuMfYSX5E=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 334333CE65E
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 08:45:20 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5E8113CB5E1
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 08:44:59 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A462D1401221
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 08:44:58 +0100 (CET)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-56a0c0a7ebcso3818550a12.1
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 00:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1710920698; x=1711525498; darn=lists.linux.it;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IN2UpWDISowdxprR3el3Qtbn7MgtVpGjpao7raKVDnk=;
 b=TxRKc2MKl9uhpP2gKTw1QnI6bsdGLeTgE6Ws1VyoXvEN9WMopXdMf57BzauHC4PdtN
 qGRnyQfS2bgx3d4/pBRf+s9EUhzWAIjHSo6fY8BQ76cuQZF3vXgwvmav0gf+53K9Wdw2
 2VHET5z0QxUk0pamJVn0knWbZkk3IfVoZaBeMSZX5YdN7smPpfuEfrl0XvvdTH0Wa72G
 Q34i9qjqmkh1FdsJ8vLTBAi9FyvtG52wUa0Ih77Lwznuipcn9QWwPu7FyHDGwWbXt/eM
 /+nGbTMNsCw7XRETOKqDP64+2p2JRejU+uraBjLvZo9fackTA2p7J6qfHrVALHC+LEg5
 ZrSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710920698; x=1711525498;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IN2UpWDISowdxprR3el3Qtbn7MgtVpGjpao7raKVDnk=;
 b=qX2DTmZtBviw0UDczaPEXDxjLh/rPTXSjvaTnUtp7Bpb6l4YlKK+GQA9DK5zSO9IaO
 iJTmh3Ps9W3yn9Ec4p9yMpxRLDenQkwxfgOIZ+l3cb85FuHSmnf9w+ZQmGH/hpetX/ue
 J7A9B5kRv754dnl2aDfCCH3G9dgJ2sM+Csxfc8Idj4e6kOV+fWpQ9SRpV25OmCYqnNjk
 0QdWHeT9ZxaycQZiJsPwDgSt0CBZjnpLEPWMMbqqQMXmMyT2zSuf2SSLazjy61FktnRF
 TfCd2m009C1gmKCBghmWw1t4bNWYqP3GGt/RPpkcUcTJrpTmdk/TGzpM7J9ptFePD2Zy
 qiTw==
X-Gm-Message-State: AOJu0Yyj1cKQmhaTKM8ZnoYFTU3IfvjzlCrKYswNfSWKoHgwbQf25I0p
 QkrxL1z/1CGQmk8j6PxZiH6zTiAJbamsmSFD3pcQ5ReFLkNmszrlFlF0iLrGlBI=
X-Google-Smtp-Source: AGHT+IGmytrHCapk+UR/WCZjoP2Q/GauP5J/Ip9OJwbp+PYZTCzAwKyhmS+TnFq9sMLVPT/1DO0MJQ==
X-Received: by 2002:a05:6402:c4e:b0:567:9306:5d0b with SMTP id
 cs14-20020a0564020c4e00b0056793065d0bmr14167584edb.28.1710920698051; 
 Wed, 20 Mar 2024 00:44:58 -0700 (PDT)
Received: from [192.168.178.40] ([213.220.156.63])
 by smtp.gmail.com with ESMTPSA id
 p5-20020aa7d305000000b0056a2b87787dsm3032282edq.37.2024.03.20.00.44.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Mar 2024 00:44:57 -0700 (PDT)
Message-ID: <c8d89dba-84e1-4daa-9d98-78bf10b4e0e4@suse.com>
Date: Wed, 20 Mar 2024 08:44:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Li Wang <liwang@redhat.com>, Cyril Hrubis <chrubis@suse.cz>
References: <6868ae95-b004-4fb2-8aac-7ccf96b32f90@suse.com>
 <CAEemH2eDT6gN3hw=Lz2qgnwFnnHmNYai9tqbKduSkcWfNjpERQ@mail.gmail.com>
 <Zfmj28EpMH_S0uOo@yuki>
 <CAEemH2ci5r_PKq_tOSrFC4Vk9ju3xnrGzZ=smOT+8PGBXtWCGg@mail.gmail.com>
In-Reply-To: <CAEemH2ci5r_PKq_tOSrFC4Vk9ju3xnrGzZ=smOT+8PGBXtWCGg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] New LTP documentation!
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTGksCgpPbiAzLzIwLzI0IDAzOjUyLCBMaSBXYW5nIHdyb3RlOgo+Cj4KPiBPbiBUdWUsIE1h
ciAxOSwgMjAyNCBhdCAxMDo0MeKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0BzdXNlLmN6PiB3
cm90ZToKPgo+ICAgICBIaSEKPiAgICAgPiBBbmQgSSBqdXN0IHRyaWVkIHRoYXQgdGhlIGxhdGVz
dCBMVFAgY29tcGlsZWQgJiBleGVjdXRlZCBzdWNjZWVkIG9uCj4gICAgID4gUkhFTC03LjkuCj4g
ICAgID4gQ2FuIHlvdSB1cGRhdGUgdGhlICJPbGRlc3QgdGVzdGVkIGRpc3RyaWJ1dGlvbnMiIFsx
XSBwYXJ0IGJ5IGFkZGluZzoKPiAgICAgPgo+ICAgICA+wqAgwqBSSEVMLTcuOSBNYWlwbyAoRGlz
dHJvKcKgIDMuMTAgKGtlcm5lbCnCoCA0LjguNShnY2MpCj4gICAgIDIuMTcoZ2xpYmMpwqAgLShj
bGFuZykKPgo+ICAgICBTdXJlIHdlIGNhbiBhZGQgdGhpcywgaG93ZXZlciB5b3Ugd2lsbCBiZSBy
ZXNwb25zaWJsZSBmb3IgbWFraW5nCj4gICAgIHN1cmUgaXQKPiAgICAgd29ya3MgYW5kIGF0IGxl
YXN0IGRvIHByZS1yZWxlYXNlIHRlc3RpbmcuCj4KPgo+IFllcywgb2YgY291cnNlLiBUaGFua3Mg
Zm9yIHJlbWluZGluZyBtZS4KPgpJZiBpdCdzIE9rIGZvciB5b3UsIEkgd2lsbCBhZGQgUkhFTCB0
byB0aGUgIk9sZGVzdCB0ZXN0ZWQgZGlzdHJpYnV0aW9uIiAKY2hhcHRlciBhcyBzdWdnZXN0ZWQu
Cj4KPiAtLSAKPiBSZWdhcmRzLAo+IExpIFdhbmcKCkFuZHJlYQoKLS0gCk1haWxpbmcgbGlzdCBp
bmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
