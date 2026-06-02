Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A76E8CD6E57
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 11:23:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 10C693E56C4
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 13:23:48 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F33EB3E30CC
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 13:23:29 +0200 (CEST)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6864310000CA
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 13:23:29 +0200 (CEST)
Received: by mail-qv1-xf42.google.com with SMTP id
 6a1803df08f44-8cce87d7995so51632156d6.0
 for <ltp@lists.linux.it>; Tue, 02 Jun 2026 04:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780399408; x=1781004208; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HmQKNO1A/GqHFqFVWl8RU7uHIaVKwSDwA/fx+OR4Muc=;
 b=bf1v1Ev9ZChRiGqKGL/xKO+zxndEi4gKGfDGEdtc91EpYdUXLoVjP5/QZJWbqBgNSh
 fFhQ0XkSQN3rS3fHTbnniEyYWdfoTtgcNW7mtcFmp9nFzk+H8kWgKaflLThCnBTnR8P0
 zdTC8Vtor0sSDHFGJkRklYFQdRGJ4nX1i0Y3tjMK0ZNwyEFawNL40GprMIQKo5i+3D+0
 fecCNpo5Jcpje5f5bUqZLP5E010A0rkBuvZHf3CPGoVw9ojgJkuAaoQnMHKRfzC105mG
 ZrPZurk7WzukJKm1iXdYaMn0QJfZfp4FMvKLUfy3wuKGDZX/m0+zHeI3PrEX5pwX95s7
 8YYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780399408; x=1781004208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HmQKNO1A/GqHFqFVWl8RU7uHIaVKwSDwA/fx+OR4Muc=;
 b=hplh/oGLm0OabT5tP22bWFjRuwdhaidE53q44NZ09fBGzITGrQl0jAih6g+0m1I655
 dJm78NIyd0600eyli+hZGfubfKlP3+lB9Ko1w0ve/4OUN+hGxo+NnaXZ3zQh+5nDbCn7
 VYZ5EDVcGkDSi2g8mSf3tJl6nbyQJdR5TT0rTLoKF2+S8dXS9ePYG5KMvLLRTbY8WRLv
 9bDttQtdfVo13v4drmYl0wyA8aJ8DjWwLzRawKqVzdAIv0lhGBrAfLRMc7A64uW7m6bH
 xaSR4gVlNOOkX6UuP09DYfWwx0ZUWPyvRkFq9gXOsXVJzUyLfJd7XTBxyCMDs7GLD8Va
 x/ow==
X-Gm-Message-State: AOJu0YwuP2NVKIy5cZ0i0ApZeCiNQoELjWKNYiOdgnhUjYYNv5+0GzfC
 Jw4nKel1dXDOz+zSC8lJPzapLiUBX8HbqUfk9B/asx2mYuH3rBoWJ6VU
X-Gm-Gg: Acq92OF4FdkHjdUUrh+ZfgEdwWrh/unC1ZOHrdm5KN9p6I2Nu1cBMs0chVQfAjV/2Xy
 ig0DCyOjXEstE74Ic7AR3PISAZspUL/+8OH7pSjK+L8GktoJMoZWZUKsa48/uZOZ+0j+jM+OmHJ
 KFtevs5eXe52bicJ/8uMp2ML/xo+o5JyouRVSo8ZyxuxcsLkbXHA6tnun5K+1TUbxYcZTlNWytl
 rTxI9lltww4dl6AGx/0twgakQFGDh3GUO+A4b1i4cKCmem9SnejkGnmnaUSPR1ffbF6kKxUxtg5
 RANnf3QWkysGBmdp+j98E/9TXkSIdUHoQpyzTMnIL0u+u2q/jPKavphdDZZ0bPNygYiRWwCuyqH
 x7fdR9i/zeHRysy3CRcMpSmuzDk+7znjU1DfJfRNEyV6CeIG3gM+eeZLzZ2TmgljYbwqJj7nQIt
 UzkJDXoK63KMdDW3lNBjjXsRsHgsqd6bxWMme1h60Y1AXz//jofhgdViFTCSUiU4sk46BKjFmIi
 TWAfhpLYSvj1jUYUbv4tKBLHfov+FMnPLqBF7Eks+HU/u9n
X-Received: by 2002:a05:622a:2606:b0:517:6c6f:8ee3 with SMTP id
 d75a77b69052e-5176c6f9251mr25961151cf.10.1780399407828; 
 Tue, 02 Jun 2026 04:23:27 -0700 (PDT)
Received: from
 runnervm3jyl0.thalhjjse5aevfwueukddivcod.cx.internal.cloudapp.net
 ([40.79.247.67]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51741b29745sm78441581cf.8.2026.06.02.04.23.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 04:23:27 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Samir <samir@linux.ibm.com>
Date: Tue,  2 Jun 2026 11:23:26 +0000
Message-ID: <20260602112326.3920-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602095656.404290-1-samir@linux.ibm.com>
References: <20260602095656.404290-1-samir@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] cfs-scheduler: Fixed "make check" errors and warnings in
 hackbench.c
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgU2FtaXIsCgpTb21lIGlzc3VlcyBuZWVkIHRvIGJlIGFkZHJlc3NlZCBiZWZvcmUgdGhpcyBj
YW4gYmUgbWVyZ2VkLgoKT24gVHVlLCAwMiBKdW4gMjAyNiAxMTo1Njo1NiArMDIwMCwgU2FtaXIg
PHNhbWlyQGxpbnV4LmlibS5jb20+IHdyb3RlOgo+IGNmcy1zY2hlZHVsZXI6IEZpeGVkICJtYWtl
IGNoZWNrIiBlcnJvcnMgYW5kIHdhcm5pbmdzIGluIGhhY2tiZW5jaC5jCgpbQ09NTUlUIE1FU1NB
R0VdCgoxLiBTdWJqZWN0IGxpbmUgdXNlcyBwYXN0IHRlbnNlLiBMVFAgKGxpa2UgdGhlIExpbnV4
IGtlcm5lbCkgdXNlcwogICBpbXBlcmF0aXZlIG1vb2QgaW4gY29tbWl0IHN1YmplY3RzOgoKICAg
ICBjZnMtc2NoZWR1bGVyOiBGaXggJ21ha2UgY2hlY2snIGVycm9ycyBhbmQgd2FybmluZ3MgaW4g
aGFja2JlbmNoLmMKCiAgIEFsc28sIHByZWZlciBzaW5nbGUgcXVvdGVzIG92ZXIgZG91YmxlIHF1
b3RlcyBpbiBzdWJqZWN0cy4KCjIuIFRoZSBTaWduZWQtb2ZmLWJ5IGxpbmUgY29udGFpbnMgb25s
eSBhIGZpcnN0IG5hbWUuIFRoZSBEQ08gcmVxdWlyZXMKICAgYSByZWFsIGZ1bGwgbmFtZSAoZmly
c3QgYW5kIGxhc3QpLiBQbGVhc2UgdXNlIHlvdXIgZnVsbCBuYW1lLCBlLmcuOgoKICAgICBTaWdu
ZWQtb2ZmLWJ5OiBTYW1pciBMYXN0bmFtZSA8c2FtaXJAbGludXguaWJtLmNvbT4KCjMuIFRoZSB2
ZXJzaW9uLXRyYWNraW5nIGJsb2NrIGRvZXMgbm90IGJlbG9uZyBpbiB0aGUgY29tbWl0IG1lc3Nh
Z2UgYm9keS4KICAgUmVtb3ZlIGl0IGJlZm9yZSBtZXJnaW5nOgoKICAgICBQYXRjaCB2MTogaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbHRwLzIwMjYwNDA3MDYyMzM2LjEyNzQ1NC0xLXNhbWlyQGxp
bnV4LmlibS5jb20vCiAgICAgUGF0Y2ggdjI6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2x0cC8y
MDI2MDQxMjEyMjg0Mi4xMDc0MDE3LTEtc2FtaXJAbGludXguaWJtLmNvbS8KCiAgICAgQWRkcmVz
c2VkIHJldmlldyBjb21tZW50cyBmcm9tIHBhdGNoIHYyIC0+IHBhdGNoIHYzOgogICAgIC0gQWRk
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyIGhlYWRlciBhcyByZXF1ZXN0ZWQgYnkgQW5kcmVhIENl
cnZlc2F0by4KCiAgIFRoaXMgaXMgcGF0Y2gtc3VibWlzc2lvbiBtZXRhZGF0YSBmb3IgdGhlIGNv
dmVyIGxldHRlciAvIGxvcmUgdGhyZWFkLAogICBub3QgcGFydCBvZiB0aGUgcGVybWFuZW50IGhp
c3RvcnkuCgo0LiBUaGUgYnVsbGV0LWxpc3QgYm9keSAoImhhY2tiZW5jaC5jOiAtIEFkZCBTUERY
LUxpY2Vuc2UtSWRlbnRpZmllciDigKYiKQogICBkZXNjcmliZXMgaW5kaXZpZHVhbCBsaW5lIGNo
YW5nZXMgdGhhdCBhcmUgc2VsZi1ldmlkZW50IGZyb20gdGhlIGRpZmYuCiAgIFJlcGxhY2UgaXQg
d2l0aCBvbmUgb3IgdHdvIHNlbnRlbmNlcyBleHBsYWluaW5nICp3aHkqIHRoZSBjaGFuZ2VzIHdl
cmUKICAgbWFkZSwgZS5nLjoKCiAgICAgRml4IGFsbCAibWFrZSBjaGVjayIgd2FybmluZ3MgaW4g
aGFja2JlbmNoLmMgdG8gY29tcGx5IHdpdGggdGhlIExUUAogICAgIGNvZGluZyBzdHlsZSBndWlk
ZWxpbmVzLgoKW0NPREVdCgo+IC0vKiBDb3B5cmlnaHQgUnVzdHkgUnVzc2VsbCwgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqLwo+IC0vKiBDb3B5cmln
aHQgUGllcnJlIFBlaWZmZXIgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAqLwo+IC0vKiBDb3B5cmlnaHQgWmhhbmcsIFlhbm1pbiwgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqLwo+IC0vKiBDb3B5cmlnaHQg
SW5nbyBNb2xuYXIsICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAqLwo+IC0vKiBDb3B5cmlnaHQgQXJqYW4gdmFuIGRlIFZlbiwgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqLwo+ICsvKiBBdXRob3JzOiBSdXN0
eSBSdXNzZWxsIDxydXN0eUBydXN0Y29ycC5jb20uYXU+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAqLwo+ICsvKiAgICAgICAgICBQaWVycmUgUGVpZmZlciA8cGllcnJlLnBlaWZmZXJAYnVs
bC5uZXQ+ICAgICAgICAgICAgICAgICAgICAgICAgICAqLwo+ICsvKiAgICAgICAgICBJbmdvIE1v
bG5hciA8bWluZ29AZWx0ZS5odT4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAqLwo+ICsvKiAgICAgICAgICBBcmphbiB2YW4gZGUgVmVuIDxhcmphbkBpbmZyYWRlYWQub3Jn
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAqLwo+ICsvKiAgICAgICAgICBaaGFuZywgWWFu
bWluIDx5YW5taW5femhhbmdAbGludXguaW50ZWwuY29tPiAgICAgICAgICAgICAgICAgICAgKi8K
CjUuIFRoZSBvcmlnaW5hbCBmaWxlIGxpc3RlZCB0aGVzZSBmaXZlIGNvbnRyaWJ1dG9ycyBhcyAq
Y29weXJpZ2h0IGhvbGRlcnMqCiAgICgiQ29weXJpZ2h0IFJ1c3R5IFJ1c3NlbGwiLCBldGMuKS4g
VGhlIHBhdGNoIHNpbGVudGx5IGRlbW90ZXMgdGhlbSB0bwogICBtZXJlICJBdXRob3JzIiBlbnRy
aWVzLCBzdHJpcHBpbmcgdGhlIGNvcHlyaWdodCBkZXNpZ25hdGlvbiBlbnRpcmVseS4KICAgQ29w
eXJpZ2h0IG5vdGljZXMgbXVzdCBiZSBwcmVzZXJ2ZWQuIEVpdGhlciByZXRhaW4gdGhlbSBhcyBj
b3B5cmlnaHQKICAgbGluZXMgKGFkZGluZyBlbWFpbHMgd2hlcmUga25vd24pIG9yIG9idGFpbiBl
eHBsaWNpdCBwZXJtaXNzaW9uIGZyb20KICAgZWFjaCBob2xkZXIgdG8gcmVtb3ZlIHRoZSBjb3B5
cmlnaHQgY2xhaW0uCgogICBGb3IgZXhhbXBsZToKICAgICAvKiBDb3B5cmlnaHQgUnVzdHkgUnVz
c2VsbCA8cnVzdHlAcnVzdGNvcnAuY29tLmF1PiAgICAgICAgICAgICAgICAgICAgICAgKi8KICAg
ICAvKiBDb3B5cmlnaHQgUGllcnJlIFBlaWZmZXIgPHBpZXJyZS5wZWlmZmVyQGJ1bGwubmV0PiAg
ICAgICAgICAgICAgICAgICAgKi8KICAgICAuLi4KCjYuIFRoZSBaaGFuZywgWWFubWluIGxpbmUg
aW4gdGhlIEF1dGhvcnMgYmxvY2sgaGFzIGZld2VyIHRyYWlsaW5nIHNwYWNlcwogICB0aGFuIHRo
ZSBvdGhlciBsaW5lcywgYnJlYWtpbmcgdGhlIGNvbHVtbiBhbGlnbm1lbnQ6CgogICAgIC8qICAg
ICAgICAgIFpoYW5nLCBZYW5taW4gPHlhbm1pbl96aGFuZ0BsaW51eC5pbnRlbC5jb20+ICAgICAg
ICAgICAgICAgICAgICAqLwogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgXi0tIG9ubHkgMjAgc3BhY2VzCgogICBBbGwgb3RoZXIgZW50
cmllcyBlbmQgd2l0aCAyNiBzcGFjZXMgYmVmb3JlICIqLyIuIFBhZCB0byBtYXRjaC4KCj4gLQlm
b3IgKGogPSAwOyBqIDwgbnVtX2ZkczsgaisrKSB7Cj4gLQkJU0FGRV9GUkVFKHJldl9jdHhfdGFi
W2kgKiBudW1fZmRzICsgal0pCj4gLQl9Cj4gKwlmb3IgKGogPSAwOyBqIDwgbnVtX2Zkczsgaisr
KQo+ICsJCVNBRkVfRlJFRShyZXZfY3R4X3RhYltpICogbnVtX2ZkcyArIGpdKQoKNy4gRXZlcnkg
b3RoZXIgY2FsbCB0byBTQUZFX0ZSRUUgaW4gdGhlIGZpbGUgaXMgdGVybWluYXRlZCB3aXRoIGEK
ICAgc2VtaWNvbG9uIChlLmcuICJTQUZFX0ZSRUUoc25kX2N0eF90YWJbaV0pOyIpLiBBbHRob3Vn
aCB0aGUgbWFjcm8KICAgZXhwYW5kcyB0byBhIGNvbXBvdW5kIHN0YXRlbWVudCBzbyB0aGUgc2Vt
aWNvbG9uIGlzIG5vdCBzdHJpY3RseQogICByZXF1aXJlZCwgb21pdHRpbmcgaXQgaGVyZSBjcmVh
dGVzIGFuIGluY29uc2lzdGVuY3kuIEFkZCB0aGUgc2VtaWNvbG9uOgoKICAgICBTQUZFX0ZSRUUo
cmV2X2N0eF90YWJbaSAqIG51bV9mZHMgKyBqXSk7CgpWZXJkaWN0OiBOZWVkcyByZXZpc2lvbgoK
VGhhbmtzLApMVFAgQUkgUmV2aWV3ZXIKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9s
aXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
